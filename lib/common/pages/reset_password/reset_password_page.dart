import 'package:demo_locker_app/common/pages/reset_password/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../constant/responsive.dart';
import '../../../constant/textStyle.dart';
import '../../../routes/app_route.dart';
import '../../widget/app_bar_widget.dart';
import '../../widget/fill_button_widget.dart';
import '../../widget/input_text_field.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          context,
          leadingWidget: InkWell(
            onTap: () {
              Get.offAllNamed(ROUTE_LOGIN);
            },
            child: SvgPicture.asset(
              'assets/icons/ic_back.svg',
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColorDark, BlendMode.srcIn),
            ),
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
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
                    "Reset password",
                    textAlign: TextAlign.center,
                    style: titleTextStyle.copyWith(
                        color: Theme.of(context).primaryColorDark),
                  ),
                ),
                SizedBox(
                  height: hp(1),
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 110),
                  child: Text(
                    "Create a new password",
                    textAlign: TextAlign.center,
                    style: textSmallRegularStyle.copyWith(
                        color: Theme.of(context).primaryColorLight),
                  ),
                ),
                SizedBox(
                  height: hp(3),
                ),
                Obx(
                  () => ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: InputTextField(
                      hintText: "Enter new password",
                      labelText: "Enter new password",
                      textInputAction: TextInputAction.next,
                      obscureText: !controller.isNew.value,
                      editingController: controller.newPasswordController,
                      validator: controller.authRepo?.validation?.validation(
                          type: "password",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'password is required.'),
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.isNew.value = !controller.isNew.value;
                        },
                        child: controller.isNew.value == true
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: hp(3),
                ),
                Obx(
                  () => ShowUpAnimation(
                    delayStart: const Duration(milliseconds: 160),
                    child: InputTextField(
                      hintText: "Confirm new password",
                      labelText: "Confirm new password",
                      obscureText: !controller.isTap.value,
                      editingController: controller.confirmPasswordController,
                      validator: controller.authRepo?.validation?.validation(
                          type: "password",
                          multiValidator: MultiValidator([]),
                          isRequired: true,
                          errorText: 'password is required.'),
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.isTap.value = !controller.isTap.value;
                        },
                        child: controller.isTap.value == true
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: hp(4),
                ),
                GetBuilder<ResetPasswordController>(
                  init: ResetPasswordController(),
                  initState: (_) {},
                  builder: (controller) {
                    return ShowUpAnimation(
                      delayStart: const Duration(milliseconds: 170),
                      child: AbsorbPointer(
                        absorbing: controller.isLoading.value,
                        child: FillButtonWidget(
                          isLoading: controller.isLoading.value,
                          text: "Confirm",
                          onPressed: () {
                            controller.resetPassword();
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
