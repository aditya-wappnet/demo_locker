// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_locker_app/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';

import '../no_internet/no_internet_controller.dart';

class RegistrationController extends GetxController {
  RegistrationController({this.authRepo});
  final AuthRepository? authRepo;
  RxBool isVisible = false.obs;
  final registerformKey = GlobalKey<FormState>();
  final internetController = Get.put(NoInternetController());

  //text editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController masterKeyController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  RxString countryCode = "+1".obs;
  RxString countryShortCode = "US".obs;
  String? deviceToken;

  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void registerUser(String email, String masterKey) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: masterKey,
      );

      // Store user's email in Firestore
      await _firestore.collection('users').doc(authResult.user?.uid).set({
        'email': email,
        'uid': authResult.user?.uid,
      });
      Get.offAllNamed(ROUTE_LOGIN);
    } catch (error) {
      print('Registration error: $error');
    }
  }
}
