import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../helpers/enum.dart';
import '../../../helpers/helpers.dart';
import '../../../routes/app_route.dart';
import '../no_internet/no_internet_controller.dart';

class RegistrationController extends GetxController {
  RegistrationController({this.authRepo});
  final AuthRepository? authRepo;
  RxBool isVisible = false.obs;
  final registerformKey = GlobalKey<FormState>();
  final internetController = Get.put(NoInternetController());

  //text editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  RxString countryCode = "+1".obs;
  RxString countryShortCode = "US".obs;
  String? deviceToken;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  registration() {
    if (internetController.isinternetConnected.value == true) {
      if (registerformKey.currentState!.validate()) {
        isLoading.value = true;
        update();
        authRepo?.registerUser(jsonData: {
          "email": emailController.text.trim(),
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
          "password": passwordController.text.trim(),
          'phone_number': contactNumberController.text.toString(),
          'country_code': "+${countryCode.value}",
          'device_type': Platform.isAndroid ? "1" : "2",
          'device_token': deviceToken
        }).then((response) async {
          if (response != null) {
            isLoading.value = false;
            if (response.statusCode == 200) {
              Get.toNamed(ROUTE_OTP_VERIFICATION,
                  arguments: [true, emailController.text, false]);
              emailController.clear();
              firstNameController.clear();
              lastNameController.clear();
              passwordController.clear();
              contactNumberController.clear();
              getSnackBar(response.data['message'] ?? "", SNACK.SUCCESS);
              update();
            } else if (response.statusCode == 403) {
              Get.toNamed(ROUTE_OTP_VERIFICATION,
                  arguments: [true, emailController.text, true, true]);
              emailController.clear();
              firstNameController.clear();
              lastNameController.clear();
              passwordController.clear();
              contactNumberController.clear();
              update();
            } else {
              getSnackBar('Email is already taken.', SNACK.FAILED);
              update();
            }
          } else {
            isLoading.value = false;
            getSnackBar(
                "Something went wrong,please try again later.", SNACK.FAILED);
            update();
          }
        });
      }
    } else {
      getSnackBar("No Internet Connection. Please try again.", SNACK.FAILED);
    }
  }
}
