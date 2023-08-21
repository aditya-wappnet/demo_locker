import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../helpers/enum.dart';
import '../../../helpers/helpers.dart';
import '../../../managers/authentication_manager.dart';
import '../../../routes/app_route.dart';
import '../no_internet/no_internet_controller.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository? authRepo;
  ForgotPasswordController({this.authRepo});
  late AuthenticationManager auth;
  final forgotPasswordKey = GlobalKey<FormState>();
  final internetController = Get.put(NoInternetController());
  RxBool isLoading = false.obs;
  String? lang;

  //text editing controller
  final TextEditingController emailController = TextEditingController();

  void onInit() {
    auth = Get.find();
    final email = Get.arguments;
    emailController.text = email ?? auth.userData.value.user?.email ?? "";
    super.onInit();
  }

  forgotPassword() {
    if (internetController.isinternetConnected.value == true) {
      if (forgotPasswordKey.currentState!.validate()) {
        isLoading.value = true;
        update();
        authRepo?.forgotPassword(jsonData: {
          "email": emailController.text.trim(),
          "lang": "en"
        }).then((response) async {
          if (response != null) {
            isLoading.value = false;
            update();
            if (response.statusCode == 200) {
              getSnackBar(response.data['message'], SNACK.SUCCESS);
              Get.toNamed(ROUTE_OTP_VERIFICATION,
                  arguments: [false, emailController.text]);
              update();
            } else {
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
      }
    } else {
      getSnackBar("No Internet Connection. Please try again.", SNACK.FAILED);
    }
  }
}
