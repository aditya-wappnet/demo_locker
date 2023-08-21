import 'dart:async';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../helpers/enum.dart';
import '../../../helpers/helpers.dart';
import '../../../managers/authentication_manager.dart';
import '../../../routes/app_route.dart';
import '../../widget/success_bottomsheet.dart';
import 'model/otp_verification_model.dart';

class OtpVerificationController extends GetxController {
  OtpVerificationController({this.authRepo});
  final AuthRepository? authRepo;
  late AuthenticationManager auth;
  OtpFieldController otpController = OtpFieldController();
  bool? isEmailVerification;
  String? email;
  String? otp;

  RxBool isResendAgain = true.obs;
  RxBool isOtpVerify = false.obs;
  Rx<int> start = 60.obs;
  Timer? timer;
  Rx<String> pin = "".obs;
  bool? isLogin, isRestoreAccount;

  @override
  void onInit() {
    auth = Get.find();
    var argumentLength = Get.arguments;
    if (Get.arguments != null) {
      if (argumentLength.length == 3) {
        isEmailVerification = Get.arguments[0];
        email = Get.arguments[1];
        isLogin = Get.arguments[2];
        if (isLogin == true) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            resendOtp(true);
          });
        }
      } else if (argumentLength.length == 4) {
        isEmailVerification = Get.arguments[0];
        email = Get.arguments[1];
        isLogin = Get.arguments[2];
        isRestoreAccount = Get.arguments[3];
        if (isLogin == true) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            resendOtp(true);
          });
        }
      } else {
        isEmailVerification = Get.arguments[0];
        email = Get.arguments[1];
      }
    }
    update();
    super.onInit();
  }

  void resend() {
    isResendAgain.value = false;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (start.value == 0) {
          start.value = 60;
          isResendAgain.value = true;
          timer.cancel();
          update();
        } else {
          start.value = start.value - 1;
          update();
        }
      },
    );
  }

  void verifyEmail() {
    if (otp != null) {
      isOtpVerify.value = true;
      update();
      authRepo?.verifyEmail(jsonData: {
        "email": email,
        "otp": otp,
        "lang": "en"
      }).then((response) {
        if (response != null) {
          isOtpVerify.value = false;
          update();
          if (response.statusCode == 200) {
            if (isRestoreAccount == true) {
              resetSuccessFull(
                  "your_account_restored_successfully", Get.context);
              update();
            } else {
              isEmailVerification == true
                  ? resetSuccessFull("email_verified_successfully", Get.context)
                  : Get.toNamed(ROUTE_RESET_PASSWORD);
            }

            otpController.clear();
          } else {
            getSnackBar(response.data['message'], SNACK.FAILED);
            update();
          }
        } else {
          isOtpVerify.value = false;
          update();
          getSnackBar(
              "Something went wrong,please try again later.", SNACK.FAILED);
          update();
        }
      });
    } else {
      getSnackBar("Enter otp", SNACK.FAILED);
    }
  }

  void resendOtp(isLogin) {
    if (isEmailVerification == true) {
      isLogin == true ? null : resend();
      otpController.clear();
      update();
      authRepo?.resendOtp(jsonData: {"email": email, "lang": "en"}).then(
          (response) {
        if (response != null) {
          if (response.statusCode == 200) {
            getSnackBar(response.data['message'], SNACK.SUCCESS);
            update();
          } else {
            getSnackBar(response.data['message'], SNACK.FAILED);
            update();
          }
        } else {
          getSnackBar(
              "Something went wrong,please try again later.", SNACK.FAILED);
          update();
        }
      });
    } else {
      isLogin == true ? null : resend();
      otpController.clear();
      update();
      authRepo?.forgotPassword(jsonData: {"email": email, "lang": "en"}).then(
          (response) async {
        if (response != null) {
          if (response.statusCode == 200) {
            getSnackBar(response.data['message'], SNACK.SUCCESS);
            update();
          } else {
            getSnackBar(response.data['message'], SNACK.FAILED);
            update();
          }
        } else {
          getSnackBar(
              "Something went wrong,please try again later.", SNACK.FAILED);
          update();
        }
      });
    }
  }

  verifyForgotPasswordotp() {
    if (otp != null) {
      isOtpVerify.value = true;
      update();
      authRepo?.otpVerification(jsonData: {
        "email": email,
        "otp": pin.value.toString(),
        "lang": "en"
      }).then((response) async {
        if (response != null) {
          isOtpVerify.value = false;
          update();
          if (response.statusCode == 200) {
            OtpVerificationModel otpVerificationModel =
                OtpVerificationModel.fromJson(response.data);
            isEmailVerification == true
                ? resetSuccessFull("email_verified_successfully", Get.context)
                : Get.toNamed(ROUTE_RESET_PASSWORD,
                    arguments: [email, otpVerificationModel.data?.token]);
            otpController.clear();
            getSnackBar(response.data['message'], SNACK.SUCCESS);
            update();
          } else {
            getSnackBar(response.data['message'], SNACK.FAILED);
            update();
          }
        } else {
          isOtpVerify.value = false;
          getSnackBar(
              "Something went wrong,please try again later.", SNACK.FAILED);
          update();
        }
      });
    } else {
      getSnackBar("Enter otp", SNACK.FAILED);
    }
  }
}
