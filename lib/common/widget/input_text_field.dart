import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constant/string.dart';
import '../../constant/textStyle.dart';

class InputTextField extends StatelessWidget {
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
  final EdgeInsets contentPadding;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final void Function(String)? onFieldSubmitted;
  final MultiValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onTap;
  final TextCapitalization? textCapitalization;

  const InputTextField({
    required this.hintText,
    this.onChanged,
    this.contentPadding = const EdgeInsets.only(left: 10),
    this.onFieldSubmitted,
    this.labelText,
    this.validator,
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
    this.inputFormatters,
    this.obscureText,
    this.editingController,
    this.maxLength,
    this.onTogglePassword,
    this.keyboardType,
    this.readOnly,
    this.autovalidateMode,
    this.textCapitalization,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onTap: onTap,
        autovalidateMode: autovalidateMode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters ?? [],
        validator: validator ?? MultiValidator([]),
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
          counterText: "",
          alignLabelWithHint: true,
          labelText: labelText,
          floatingLabelStyle: smallRegularStyle.copyWith(
              color: Theme.of(context).primaryColorLight),
          errorStyle: smallRegularStyle.copyWith(color: Colors.red),
          hintText: hintText,
          labelStyle: textSmallRegularStyle.copyWith(
              color: Theme.of(context).primaryColorLight),
          hintStyle: textSmallRegularStyle.copyWith(
              color: Theme.of(context).primaryColorLight),
          prefixIcon: prefixIcon,
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                ),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                ),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
          contentPadding: contentPadding,
          errorMaxLines: errorMaxLines ?? 2,
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                ),
              ),
          suffixIcon: suffixIcon,
        ),
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 100,
      ),
    );
  }
}
