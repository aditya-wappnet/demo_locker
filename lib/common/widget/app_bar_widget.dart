import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constant/textStyle.dart';

AppBar AppBarWidget(
  BuildContext context, {
  String title = "",
  Widget? titleWidget,
  Widget? leadingWidget,
  List<Widget>? actions,
  bool? centerTitle = true,
}) {
  return AppBar(
    leading: leadingWidget ??
        InkWell(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(
            'assets/icons/ic_back.svg',
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColorDark, BlendMode.srcIn),
          ),
        ),
    title: titleWidget ??
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: smallTitleTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
        ),
    actions: actions,
  );
}
