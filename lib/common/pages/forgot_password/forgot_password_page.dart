import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../widget/app_bar_widget.dart';
import '../../widget/fill_button_widget.dart';
import '../../widget/input_text_field.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context),
      body: Form(
        key: controller.forgotPasswordKey,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: wp(6),
            ),
            children: [
              ShowUpAnimation(
                delayStart: const Duration(milliseconds: 100),
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.center,
                  style: titleTextStyle.copyWith(
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              SizedBox(
                height: hp(2),
              ),
              ShowUpAnimation(
                delayStart: const Duration(milliseconds: 150),
                child: Text(
                  "Please enter your email address, You will receive a link to create a new password.",
                  style: textRegularStyle.copyWith(
                      color: Theme.of(context).primaryColorLight),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: hp(3),
              ),
              ShowUpAnimation(
                delayStart: const Duration(milliseconds: 190),
                child: InputTextField(
                  hintText: "Email address",
                  labelText: "Email address",
                  editingController: controller.emailController,
                  validator: controller.authRepo?.validation?.validation(
                      type: "email",
                      multiValidator: MultiValidator([]),
                      isRequired: true,
                      errorText: 'email is required.'),
                  onFieldSubmitted: (p0) {
                    controller.forgotPassword();
                  },
                ),
              ),
              SizedBox(
                height: hp(4),
              ),
              GetBuilder<ForgotPasswordController>(
                init: ForgotPasswordController(),
                initState: (_) {},
                builder: (controller) {
                  return ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 190),
                    child: AbsorbPointer(
                      absorbing: controller.isLoading.value,
                      child: FillButtonWidget(
                        isLoading: controller.isLoading.value,
                        text: "Send",
                        onPressed: () {
                          controller.forgotPassword();
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: hp(4),
              ),
              ShowUpAnimation(
                delayStart: const Duration(milliseconds: 210),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context).primaryColorLight),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Login here",
                        style: textBodyStyle.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
