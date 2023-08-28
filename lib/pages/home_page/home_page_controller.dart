// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convert/convert.dart';
import 'package:demo_locker_app/pages/home_page/custom_popup_share/helper/fetch_rsa_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_popup_share/helper/encrypt_decrypt.dart';

class HomeController extends GetxController {
  final TextEditingController creditCardNumberController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  late Uint8List encryptionKey;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    initializeEncryptionKey();
    fetchAndPrintUserPublicKey();
    fetchAndPrintUserPrivateKey();
  }

  void fetchAndPrintUserPublicKey() async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      final userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        final publicKey = userDocSnapshot.data()?['publicKey'];
        final printPublicKey = RsaKeyHelper().parsePublicKeyFromPem(publicKey);
        print("printPublicKey-$printPublicKey");
        print('Modulus: ${printPublicKey.modulus}');
        print('Exponent: ${printPublicKey.exponent}');
      }
    }
  }

  void fetchAndPrintUserPrivateKey() async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      final userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        final privateKey = userDocSnapshot.data()?['privateKey'];
        print("printEncryptPrivateKey-$privateKey");
        final decryptedPrivateKey = decryptData(privateKey, encryptionKey);
        print("{printEncryptPublicKey - $decryptedPrivateKey}");
        final printPrivateKey =
            RsaKeyHelper().parsePrivateKeyFromPem(decryptedPrivateKey);
        print("printPublicKey-$printPrivateKey");
      }
    }
  }

/*   String decryptPrivateKey(
    String encryptedPrivateKey, RSAPrivateKey privateKey, String encryptionKeyHex) {
  final rsaDecrypter = RSAEngine()
    ..init(
      false,
      PrivateKeyParameter<RSAPrivateKey>(privateKey),
    );

  final cipherText = base64.decode(encryptedPrivateKey);

  final decryptedEncryptionKey = rsaDecrypter.process(cipherText);
  
  final decryptedKeyHex = hex.encode(decryptedEncryptionKey);

  return decryptedKeyHex;
} */

  void initializeEncryptionKey() {
    const String encryptionKeyHex =
        'e172a0e8f82f9e3425b0d2d9af74fe2bf497297d8af5c7f10027e3c11c5949c6';
    encryptionKey = Uint8List.fromList(hex.decode(encryptionKeyHex));
  }

  void storeEncryptedCreditCardInfo({
    required String creditCardNumber,
    required String cvv,
    required String expiryDate,
    required String pin,
  }) async {
    final encryptedCreditCardInfo = {
      'creditCardNumber': encryptData(creditCardNumber, encryptionKey),
      'cvv': encryptData(cvv, encryptionKey),
      'expiryDate': encryptData(expiryDate, encryptionKey),
      'pin': encryptData(pin, encryptionKey),
      'uniqueId': '',
    };

    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final userDocRef = FirebaseFirestore.instance
          .collection('CreditCardRecords')
          .doc(userId);

      final subcollectionRef = userDocRef.collection('Records');
      final docRef = await subcollectionRef.add(encryptedCreditCardInfo);

      // Update the uniqueId field with the generated document ID
      await docRef.update({'uniqueId': docRef.id});

      clearTextFields();
    }
  }

  Stream<List<Map<String, dynamic>>> fetchAndDecryptCreditCardInfoStream() {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return Stream.value(
          []); // Return an empty stream if no user is logged in.
    }

    final subcollectionRef = FirebaseFirestore.instance
        .collection('CreditCardRecords')
        .doc(userId)
        .collection('Records');

    return subcollectionRef.snapshots().map((subcollectionSnapshot) {
      final decryptedCreditCardInfoList =
          subcollectionSnapshot.docs.map((subDoc) {
        final encryptedData = subDoc.data();
        return retrieveAndDecryptCreditCardInfo(encryptedData);
      }).toList();

      return decryptedCreditCardInfoList;
    });
  }

  Map<String, dynamic> retrieveAndDecryptCreditCardInfo(
      Map<String, dynamic> encryptedData) {
    final decryptedCreditCardInfo = {
      'creditCardNumber':
          decryptData(encryptedData['creditCardNumber'], encryptionKey),
      'cvv': decryptData(encryptedData['cvv'], encryptionKey),
      'expiryDate': decryptData(encryptedData['expiryDate'], encryptionKey),
      'pin': decryptData(encryptedData['pin'], encryptionKey),
    };

    return decryptedCreditCardInfo;
  }

  void clearTextFields() {
    creditCardNumberController.clear();
    cvvController.clear();
    expiryDateController.clear();
    pinController.clear();
  }
}
