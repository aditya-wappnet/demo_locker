import 'package:flutter/material.dart';

import '../../constant/responsive.dart';
import '../../constant/string.dart';
import '../../constant/style.dart';
import '../../constant/textStyle.dart';

class FillSmallButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color;
  final TextStyle? textstyle;
  final double? height;
  final double? width;
  final Widget? trailing;
  final Widget? leading;

  const FillSmallButton({
    required this.text,
    required this.onPressed,
    Key? key,
    this.padding,
    this.textstyle,
    this.color,
    this.height,
    this.width,
    this.trailing,
    this.leading,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? hp(5),
        width: width,
        padding: padding ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: hp(1),
                width: wp(2),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: COLOR_BACKGROUND,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leading ?? const SizedBox.shrink(),
                  Text(
                    text,
                    style: textstyle ??
                        textMediumStyle.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  trailing ?? const SizedBox.shrink()
                ],
              ),
      ),
    );
  }
}
