import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/responsive.dart';
import '../../constant/string.dart';
import '../../constant/style.dart';
import '../../constant/textStyle.dart';
import '../../routes/app_route.dart';
import 'fill_small_button.dart';

resetSuccessFull(String? title, context) {
  Get.bottomSheet(
    backgroundColor: Theme.of(context).brightness == Brightness.light
        ? COLOR_BACKGROUND
        : Colors.black,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(BORDER_RADIUS),
        topRight: Radius.circular(BORDER_RADIUS),
      ),
    ),
    Wrap(
      children: [
        WillPopScope(
          onWillPop: () async {
            Get.offAllNamed(ROUTE_LOGIN);
            return true;
          },
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BORDER_RADIUS),
                topRight: Radius.circular(BORDER_RADIUS),
              ),
            ),
            padding: EdgeInsets.all(wp(5)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.done,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  Text(
                    "Success",
                    style: textMediumStyle.copyWith(
                        fontSize: 32, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: hp(1)),
                  Text(
                    "$title",
                    textAlign: TextAlign.center,
                    style: textRegularStyle.copyWith(
                        color: Theme.of(context).primaryColorLight),
                  ),
                  SizedBox(
                    height: hp(6),
                  ),
                  FillSmallButton(
                    height: hp(6.3),
                    text: "Back to Login ",
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.offAllNamed(ROUTE_LOGIN);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
