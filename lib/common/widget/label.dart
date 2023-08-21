import 'package:flutter/material.dart';

import '../../constant/responsive.dart';
import '../../constant/textStyle.dart';

class LabelWidget extends StatelessWidget {
  final Color color;
  final String title;
  final TextStyle? testStyle;
  const LabelWidget(
      {required this.color, required this.title, this.testStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: hp(0.2), horizontal: wp(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color,
      ),
      child: Text(
        title,
        maxLines: 2,
        style: testStyle ??
            textSmallMediumStyle.copyWith(
                color: Theme.of(context).primaryColor),
      ),
    );
  }
}
