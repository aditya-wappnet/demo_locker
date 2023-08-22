// ignore_for_file: avoid_print, implementation_imports

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';

import "package:pointycastle/export.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../managers/authentication_manager.dart';
import '../../../routes/app_route.dart';
import '../no_internet/no_internet_controller.dart';
import 'model/login_model.dart';

class LoginController extends GetxController {
  LoginController({this.authRepo});
  final AuthRepository? authRepo;
  late AuthenticationManager auth;
  final loginformKey = GlobalKey<FormState>();
  RxBool isVisible = false.obs;
  RxBool isLoading = false.obs;
  String deviceToken = "";
  final internetController = Get.put(NoInternetController());

  //text editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    auth = Get.find();
    super.onInit();
  }

  redirectToForgotPassword() {
    Get.toNamed(ROUTE_FORGOTPASSWORD, arguments: emailController.text);
  }

  redirectToRegistrastion() {
    Get.toNamed(ROUTE_REGISTATION);
  }

  LoginData? loginData;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Other necessary dependencies

  void login(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authResult.user != null) {
        final encryptionKey =
            generateEncryptionKey(password, email, authResult.user!.uid);
        final encryptionKeyHex = uint8ListToHex(encryptionKey);
        print("Generated Encryption Key: $encryptionKeyHex");

        final keyPair = generateRSAkeyPair(exampleSecureRandom());

        final publicKey = keyPair.publicKey;
        final privateKey = keyPair.privateKey;

        print('Generated Public Key:');
        print(publicKeyToPem(publicKey));

        print('Generated Private Key:');
        print(privateKeyToPem(privateKey));

        /* print('Generated Public Key:');
        print('Modulus: ${publicKey.modulus}');
        print('Exponent: ${publicKey.exponent}');

        print('Generated Private Key:');
        print('Modulus: ${privateKey.modulus}');
        print('Private Exponent: ${privateKey.privateExponent}'); */
        // Update the user's document in Firestore with the encrypted private key and unencrypted public key
        await updateUserDocumentWithKeys(
            authResult.user!.uid,
            encryptPrivateKey(
                privateKeyToPem(privateKey), publicKey, encryptionKeyHex),
            publicKeyToPem(publicKey));

        //Get.offAllNamed(ROUTE_HOME);
      }
    } catch (error) {
      print('Login error: $error');
    }
  }

  Uint8List bigIntToBytes(BigInt value, int size) {
    final byteList = List<int>.filled(size, 0);

    for (var i = size - 1; i >= 0; i--) {
      final byte = value & BigInt.from(0xff);
      byteList[i] = byte.toInt();
      value >>= 8;
    }

    return Uint8List.fromList(byteList);
  }

  String publicKeyToPem(RSAPublicKey publicKey) {
    final modulusBytes = bigIntToBytes(
        publicKey.modulus!, (publicKey.modulus!.bitLength + 7) ~/ 8);
    final exponentBytes = bigIntToBytes(
        publicKey.exponent!, (publicKey.exponent!.bitLength + 7) ~/ 8);

    final modulusBase64 = base64Encode(modulusBytes);
    final exponentBase64 = base64Encode(exponentBytes);

    final pemString = '''
-----BEGIN PUBLIC KEY-----
$modulusBase64
$exponentBase64
-----END PUBLIC KEY-----
''';

    return pemString;
  }

  String privateKeyToPem(RSAPrivateKey privateKey) {
    final modulusBytes = bigIntToBytes(
        privateKey.modulus!, (privateKey.modulus!.bitLength + 7) ~/ 8);
    final privateExponentBytes = bigIntToBytes(privateKey.privateExponent!,
        (privateKey.privateExponent!.bitLength + 7) ~/ 8);
    final pBytes =
        bigIntToBytes(privateKey.p!, (privateKey.p!.bitLength + 7) ~/ 8);
    final qBytes =
        bigIntToBytes(privateKey.q!, (privateKey.q!.bitLength + 7) ~/ 8);
    final dPBytes = bigIntToBytes(
        privateKey.privateExponent! % (privateKey.p! - BigInt.one),
        (privateKey.p!.bitLength + 7) ~/ 8);
    final dQBytes = bigIntToBytes(
        privateKey.privateExponent! % (privateKey.q! - BigInt.one),
        (privateKey.q!.bitLength + 7) ~/ 8);
    final qInvBytes = bigIntToBytes(privateKey.q!.modInverse(privateKey.p!),
        (privateKey.p!.bitLength + 7) ~/ 8);

    final modulusBase64 = base64Encode(modulusBytes);
    final privateExponentBase64 = base64Encode(privateExponentBytes);
    final pBase64 = base64Encode(pBytes);
    final qBase64 = base64Encode(qBytes);
    final dPBase64 = base64Encode(dPBytes);
    final dQBase64 = base64Encode(dQBytes);
    final qInvBase64 = base64Encode(qInvBytes);

    final pemString = '''
-----BEGIN RSA PRIVATE KEY-----
$modulusBase64
$privateExponentBase64
$pBase64
$qBase64
$dPBase64
$dQBase64
$qInvBase64
-----END RSA PRIVATE KEY-----
''';

    return pemString;
  }

  String encryptPrivateKey(
      String privateKey, RSAPublicKey publicKey, String encryptionKeyHex) {
    final rsaEncrypter = RSAEngine()
      ..init(
        true,
        PublicKeyParameter<RSAPublicKey>(publicKey),
      );

    final encryptionKey = Uint8List.fromList(hex.decode(encryptionKeyHex));

    final cipherText = rsaEncrypter.process(encryptionKey);

    final encryptedPrivateKey = base64.encode(cipherText);

    return encryptedPrivateKey;
  }

  Uint8List generateEncryptionKey(
      String masterKey, String email, String userId) {
    const fixedValue = '123456789012'; // Replace with your 12-digit value
    final combinedValue = masterKey + email + fixedValue + userId;

    final pbkdf2 = PBKDF2KeyDerivator(
      HMac(SHA256Digest(), 64), // Use SHA-256 and 64-byte output
    );

    final salt = Uint8List.fromList(utf8.encode(userId)); // Use user ID as salt
    pbkdf2.init(Pbkdf2Parameters(salt, 10000, 32)); // 32-byte (256-bit) key

    final key = pbkdf2.process(Uint8List.fromList(utf8.encode(combinedValue)));
    return Uint8List.fromList(key);
  }

  String uint8ListToHex(Uint8List data) {
    return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<void> updateUserDocumentWithKeys(
      String userId, String encryptedPrivateKey, String publicKey) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Update the user document with the encrypted private key and unencrypted public key
    await userDocRef.update({
      'privateKey': encryptedPrivateKey,
      'publicKey': publicKey,
    });
  }

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
      SecureRandom secureRandom,
      {int bitLength = 2048}) {
    // Create an RSA key generator and initialize it

    // final keyGen = KeyGenerator('RSA'); // Get using registry
    final keyGen = RSAKeyGenerator();

    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
        secureRandom));

    // Use the generator

    final pair = keyGen.generateKeyPair();

    // Cast the generated key pair into the RSA key types

    final myPublic = pair.publicKey as RSAPublicKey;
    final myPrivate = pair.privateKey as RSAPrivateKey;

    return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
  }

  SecureRandom exampleSecureRandom() {
    final secureRandom = SecureRandom('Fortuna')
      ..seed(
          KeyParameter(Platform.instance.platformEntropySource().getBytes(32)));
    return secureRandom;
  }
}
