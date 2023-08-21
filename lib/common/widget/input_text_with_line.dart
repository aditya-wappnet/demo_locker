import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constant/style.dart';
import '../../constant/textStyle.dart';

class InputTextWithLine extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Widget? prefixIcon;
  final String? labelText;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final int? minLines;
  final int? errorMaxLines;
  final double? height;
  final int? maxLines;
  final ValueChanged? onChanged;
  final void Function()? onTogglePassword;
  final int? maxLength;
  final TextEditingController? editingController;
  final TextInputType? keyboardType;
  final bool changeTextStyle;
  final bool? readOnly;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final void Function(String)? onFieldSubmitted;
  final MultiValidator? validator;

  const InputTextWithLine({
    required this.hintText,
    this.onChanged,
    this.contentPadding,
    this.onFieldSubmitted,
    this.labelText,
    this.textInputAction,
    this.changeTextStyle = false,
    this.height,
    this.minLines,
    this.maxLines,
    this.errorMaxLines,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.lableStyle,
    this.hintStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.editingController,
    this.maxLength,
    this.onTogglePassword,
    this.keyboardType,
    this.readOnly,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      validator: validator ?? MultiValidator([]),
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: textInputAction,
      controller: editingController,
      cursorColor: const Color(0xFF2B547E),
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      style: textSmallMediumStyle.copyWith(
          color: Theme.of(context).primaryColorDark),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding:
            contentPadding ?? EdgeInsets.only(top: 15.0, bottom: 15.0),
        labelText: labelText,
        floatingLabelStyle: smallRegularStyle.copyWith(color: Colors.blue),
        errorStyle: smallRegularStyle.copyWith(
          color: Colors.red,
        ),
        hintText: hintText,
        labelStyle: textSmallRegularStyle.copyWith(
            color: Theme.of(context).primaryColorLight),
        hintStyle: textSmallRegularStyle.copyWith(
            color: Theme.of(context).primaryColorLight),
        prefixIcon: prefixIcon,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColorLight.withOpacity(0.5)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColorLight.withOpacity(0.5)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColorLight.withOpacity(0.5)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: COLOR_RED.withOpacity(0.5)),
        ),
        suffixIcon: suffixIcon,
      ),
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
    );
  }
}
