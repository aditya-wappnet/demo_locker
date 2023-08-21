import 'package:flutter/material.dart';

import '../../constant/responsive.dart';
import '../../constant/string.dart';
import '../../constant/style.dart';
import '../../constant/textStyle.dart';

class FillButtonWidget extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final TextStyle? textstyle;
  final double? height;
  final double? width;

  const FillButtonWidget({
    required this.text,
    required this.onPressed,
    Key? key,
    this.padding,
    this.textstyle,
    this.color,
    this.height,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height ?? hp(6.3),
        width: width ?? wp(90),
        padding: padding ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: wp(7),
                height: hp(3.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: COLOR_BACKGROUND,
                  ),
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: textstyle ??
                    textMediumStyle.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }
}
