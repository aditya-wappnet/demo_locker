import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../../routes/app_route.dart';
import '../../widget/app_bar_widget.dart';
import '../../widget/fill_button_widget.dart';
import 'otp_verification_controller.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
      init: OtpVerificationController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(
            context,
            leadingWidget: InkWell(
              onTap: () {
                controller.isEmailVerification == true
                    ? Get.offAllNamed(ROUTE_LOGIN)
                    : Get.back();
              },
              child: SvgPicture.asset(
                'assets/icons/ic_back.svg',
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColorDark, BlendMode.srcIn),
              ),
            ),
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: wp(6)),
              children: [
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 100),
                  child: Text(
                    controller.isEmailVerification == true
                        ? "Email Verification"
                        : "OTP Verification",
                    textAlign: TextAlign.center,
                    style: titleTextStyle.copyWith(
                        color: Theme.of(context).primaryColorDark),
                  ),
                ),
                SizedBox(height: hp(1.2)),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 120),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context).primaryColorLight),
                      children: [
                        const TextSpan(
                          text:
                              'We have sent the verification code to the email ',
                        ),
                        TextSpan(
                          text: "${controller.email}",
                          style: textRegularStyle.copyWith(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: hp(4),
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 160),
                  child: OTPTextField(
                    length: 5,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black26
                              : Theme.of(context).primaryColorLight,
                      focusBorderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black26
                              : Theme.of(context).primaryColorLight,
                      enabledBorderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black26
                              : Theme.of(context).primaryColorLight,
                      disabledBorderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black26
                              : Theme.of(context).primaryColorLight,
                    ),
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    width: wp(85),
                    fieldWidth: 40,
                    style: textMediumStyle.copyWith(
                        color: Theme.of(context).primaryColorDark),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (pin) {},
                    onCompleted: (pin) {
                      controller.otp = pin;
                      controller.pin.value = pin;
                      controller.isEmailVerification == true
                          ? controller.verifyEmail()
                          : controller.verifyForgotPasswordotp();
                    },
                  ),
                ),
                SizedBox(
                  height: hp(4),
                ),
                GetBuilder<OtpVerificationController>(
                  init: OtpVerificationController(),
                  initState: (_) {},
                  builder: (controller) {
                    return ShowUpAnimation(
                      delayStart: const Duration(milliseconds: 160),
                      child: AbsorbPointer(
                        absorbing: controller.isOtpVerify.value,
                        child: FillButtonWidget(
                          isLoading: controller.isOtpVerify.value,
                          text: "Verify",
                          onPressed: controller.isOtpVerify.value
                              ? () {}
                              : () {
                                  controller.isEmailVerification == true
                                      ? controller.verifyEmail()
                                      : controller.verifyForgotPasswordotp();
                                },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: hp(3),
                ),
                Obx(
                  () => controller.isResendAgain.value
                      ? const SizedBox.shrink()
                      : Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: wp(35)),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "00:${controller.start.toString().length < 2 ? "0${controller.start.toString()}" : controller.start.toString()}",
                            style: textBodyStyle.copyWith(color: Colors.white),
                          ),
                        ),
                ),
                controller.isResendAgain.value
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: hp(1.5),
                      ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn’t get the code? ",
                        style: textMediumStyle.copyWith(
                            color: Theme.of(context).primaryColorLight),
                      ),
                      AbsorbPointer(
                        absorbing: !controller.isResendAgain.value,
                        child: InkWell(
                          onTap: () {
                            if (controller.isResendAgain.value) {
                              controller.start.value == 60
                                  ? controller.resendOtp(false)
                                  : null;
                            }
                          },
                          child: Text(
                            "Resend it",
                            style: textBodyStyle.copyWith(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
