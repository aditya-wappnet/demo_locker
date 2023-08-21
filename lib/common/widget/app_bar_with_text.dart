import 'package:flutter/material.dart';

import '../../constant/textStyle.dart';

// ignore: non_constant_identifier_names
AppBar AppBarWithText(
  BuildContext context, {
  String title = "",
  Widget? titleWidget,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
  bool? centerTitle,
}) {
  return AppBar(
    leading: const SizedBox.shrink(),
    leadingWidth: 0.0,
    centerTitle: centerTitle ?? false,
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
    bottom: bottom,
  );
}
