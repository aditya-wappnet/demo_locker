import 'package:demo_locker_app/common/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../../routes/app_route.dart';
import '../../widget/fill_button_widget.dart';
import '../../widget/input_text_field.dart';
import '../../widget/phone_number_textfield.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          body: Form(
            key: controller.registerformKey,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: wp(6),
                  vertical: hp(5),
                ),
                children: [
                  Stack(
                    children: [
                      Placeholder(
                        fallbackHeight: hp(20),
                        fallbackWidth: wp(10),
                      ),
                      Positioned(
                        left: -10.0,
                        top: -5.0,
                        child: IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            Get.back();
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/ic_back.svg",
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColorDark,
                                BlendMode.srcIn),
                          ),
                        ),
                      )
                    ],
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 100),
                    child: Text(
                      "Register",
                      style: titleTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                  SizedBox(
                    height: hp(2),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 110),
                    child: Text(
                      "If you already have an account register",
                      style: textMediumStyle.copyWith(
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                  SizedBox(height: hp(0.3)),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 120),
                    child: InkWell(
                      onTap: () {
                        Get.offAllNamed(ROUTE_LOGIN);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: textMediumStyle.copyWith(
                              color: Theme.of(context).primaryColorLight),
                          children: [
                            const TextSpan(
                              text: 'You can',
                            ),
                            TextSpan(
                                text: "${' Login here'} !",
                                style: textBodyStyle.copyWith(
                                    color: Theme.of(context).primaryColorDark)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  /*  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: InputTextField(
                      hintText: "First Name",
                      labelText: "First Name",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      editingController: controller.firstNameController,
                      validator: controller.authRepo?.validation?.validation(
                          type: "name",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'first name is required.'),
                    ),
                  ), */
                  /* SizedBox(
                    height: hp(2),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: InputTextField(
                      hintText: "Last name",
                      labelText: "Last name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      editingController: controller.lastNameController,
                      validator: controller.authRepo?.validation?.validation(
                          type: "name",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'last name is required.'),
                    ),
                  ), */
                  /* SizedBox(
                    height: hp(2),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: PhoneNumberTextField(
                      initialCountryCode: controller.countryShortCode.value,
                      contentPadding: const EdgeInsets.only(
                          left: 10.0, top: 15.0, bottom: 15.0),
                      initialNumber: controller.contactNumberController.text,
                      onCountryChanged: (country) {
                        controller.countryCode.value = country.dialCode;
                        controller.update();
                      },
                      onNumberChanged: (phoneNumber) {
                        controller.contactNumberController.text =
                            phoneNumber.number;
                        controller.update();
                      },
                    ),
                  ), */
                  SizedBox(
                    height: hp(2),
                  ),
                  ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: InputTextField(
                      hintText: "Email address",
                      labelText: "Email address",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      editingController: controller.emailController,
                      validator: controller.authRepo?.validation?.validation(
                          type: "email",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'email is required.'),
                    ),
                  ),
                  SizedBox(
                    height: hp(2),
                  ),
                  Obx(() => ShowUpAnimation(
                        delayStart: const Duration(milliseconds: 160),
                        child: InputTextField(
                          hintText: "Master Password",
                          labelText: "Master Password",
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        ),
                      )),
                  SizedBox(
                    height: hp(4),
                  ),
                  GetBuilder<RegistrationController>(
                    init: RegistrationController(),
                    initState: (_) {},
                    builder: (_) {
                      return ShowUpAnimation(
                        delayStart: const Duration(milliseconds: 190),
                        child: AbsorbPointer(
                          absorbing: controller.isLoading.value,
                          child: FillButtonWidget(
                            isLoading: controller.isLoading.value,
                            text: "Register",
                            onPressed: () {
                              controller.registration();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: hp(5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
