import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../helpers/enum.dart';
import '../../../helpers/helpers.dart';
import '../../widget/success_bottomsheet.dart';

class ResetPasswordController extends GetxController {
  final AuthRepository? authRepo;
  ResetPasswordController({this.authRepo});
  final formKey = GlobalKey<FormState>();
  RxBool isTap = false.obs;
  RxBool isNew = false.obs;
  RxBool isLoading = false.obs;
  String? token;
  String? email;

  //text editing controller
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      email = Get.arguments[0];
      token = Get.arguments[1];
    }
    super.onInit();
  }

  resetPassword() {
    if (formKey.currentState!.validate() &&
        newPasswordController.text == confirmPasswordController.text) {
      isLoading.value = true;
      update();
      authRepo?.resetPassword(jsonData: {
        "email": email,
        "token": token,
        "password": newPasswordController.text.trim(),
        "lang": "en"
      }).then((response) async {
        if (response != null) {
          isLoading.value = false;
          update();
          if (response.statusCode == 200) {
            resetSuccessFull("password_change_successfully", Get.context);
            newPasswordController.clear();
            confirmPasswordController.clear();
            update();
          } else {
            isLoading.value = false;
            getSnackBar(response.data['message'], SNACK.FAILED);
            update();
          }
        } else {
          isLoading.value = false;
          getSnackBar(
              "Something went wrong,please try again later.", SNACK.FAILED);
          update();
        }
      });
    } else {
      isLoading.value = false;
      getSnackBar("Please enter same password.", SNACK.FAILED);
      update();
    }
  }
}
