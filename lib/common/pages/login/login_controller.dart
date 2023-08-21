import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/responsive.dart';
import '../../../constant/string.dart';
import '../../../constant/textStyle.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/enum.dart';
import '../../../helpers/helpers.dart';
import '../../../managers/authentication_manager.dart';
import '../../../routes/app_route.dart';
import '../../widget/fill_button_widget.dart';
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
  login() {
    if (internetController.isinternetConnected.value == true) {
      if (loginformKey.currentState!.validate()) {
        isLoading.value = true;
        update();
        authRepo?.login(jsonData: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          'device_type': Platform.isAndroid ? "1" : "2",
          'device_token': deviceToken,
          "lang": "en"
        }).then((response) async {
          if (response != null) {
            isLoading.value = false;
            update();
            if (response.statusCode == 200) {
              LoginModel loginModel = LoginModel.fromJson(response.data);
              loginData = loginModel.data;
              auth.setUser(loginData!);
              authRepo!.apiClient!.setBaseToken(loginModel.data?.token);
              auth.login(loginModel.data?.token);
              if (loginData?.user?.userType == "User") {
                Get.offAllNamed(ROUTE_NAVIGATION);
              } else {}
              emailController.clear();
              passwordController.clear();
              getSnackBar("Login Successful", SNACK.SUCCESS);
            } else {
              getSnackBar(response.data['message'] ?? "", SNACK.FAILED);
              update();
            }
          } else {
            isLoading.value = false;
            getSnackBar("User not found", SNACK.FAILED);
            update();
          }
        });
      }
    } else {
      getSnackBar("No Internet Connection. Please try again.", SNACK.FAILED);
    }
  }
}

alretDialog(context, subtitle, {String? title = ""}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        iconPadding: EdgeInsets.zero,
        titlePadding:
            title == null ? EdgeInsets.zero : EdgeInsets.only(top: hp(1.5)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: wp(6),
          vertical: title == null ? hp(2) : hp(0),
        ),
        title: Text(
          "$title",
          textAlign: TextAlign.center,
          style: textBodyStyle.copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        content: Text(
          "$subtitle",
          style: textMediumStyle.copyWith(
            fontSize: 15,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        actionsPadding: EdgeInsets.only(
          top: hp(2),
          left: wp(30),
          right: wp(30),
          bottom: hp(2),
        ),
        actions: [
          FillButtonWidget(
            height: hp(5),
            text: "Ok",
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
    },
  );
}
