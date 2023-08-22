import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../widget/fill_button_widget.dart';
import '../../widget/input_text_field.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: Form(
            key: controller.loginformKey,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: wp(6), vertical: hp(5)),
                children: [
                  Placeholder(
                    fallbackHeight: hp(30),
                    fallbackWidth: wp(20),
                  ),
                  SizedBox(
                    height: hp(4),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 300),
                    child: Text(
                      "Welcome back",
                      style: smallTitleTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 300),
                    child: InputTextField(
                      hintText: "Email address",
                      labelText: "Email address",
                      textInputAction: TextInputAction.next,
                      editingController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.authRepo?.validation?.validation(
                          type: "email",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'Email is required.'),
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  Obx(() => ShowUpAnimation(
                        delayStart: const Duration(milliseconds: 350),
                        child: InputTextField(
                          hintText: "Master Password",
                          labelText: "MasterPassword",
                          textInputAction: TextInputAction.done,
                          editingController: controller.passwordController,
                          obscureText: !controller.isVisible.value,
                          validator: controller.authRepo?.validation
                              ?.validation(
                                  type: "password",
                                  multiValidator: MultiValidator([]),
                                  isRequired: true,
                                  errorText: 'master password is required.'),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.isVisible.value =
                                  !controller.isVisible.value;
                            },
                            child: controller.isVisible.value
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                          onFieldSubmitted: (p0) {},
                        ),
                      )),
                  SizedBox(
                    height: hp(3),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 350),
                    child: Padding(
                      padding: EdgeInsets.only(left: wp(42)),
                      child: InkWell(
                        onTap: () {
                          controller.redirectToForgotPassword();
                        },
                        child: Text(
                          "Forgot password",
                          style: textMediumStyle.copyWith(
                              color: Theme.of(context).primaryColorDark),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  GetBuilder<LoginController>(
                    init: LoginController(),
                    initState: (_) {},
                    builder: (controller) {
                      return ShowUpAnimation(
                        delayStart: const Duration(milliseconds: 360),
                        child: AbsorbPointer(
                          absorbing: controller.isLoading.value,
                          child: FillButtonWidget(
                            isLoading: controller.isLoading.value,
                            text: "Login",
                            onPressed: () {
                              controller.login(controller.emailController.text,
                                  controller.passwordController.text);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: hp(20),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 370),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have a account?",
                          style: textMediumStyle.copyWith(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        InkWell(
                          onTap: () {
                            controller.redirectToRegistrastion();
                          },
                          child: Text(
                            "Register",
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
      },
    );
  }
}
