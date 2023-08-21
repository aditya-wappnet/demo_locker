import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../constant/responsive.dart';
import '../../constant/string.dart';
import '../../constant/textStyle.dart';

class PhoneNumberTextField extends StatelessWidget {
  final String? initialCountryCode;
  final Function(PhoneNumber)? onNumberChanged;
  final Function(Country)? onCountryChanged;
  final bool? readOnly;
  final String? initialNumber;
  final EdgeInsets? contentPadding;
  final TextEditingController? editingController;
  final InputBorder? border, enabledBorder, focusedBorder, errorBorder;

  const PhoneNumberTextField({
    super.key,
    this.initialCountryCode,
    this.onNumberChanged,
    this.readOnly,
    this.onCountryChanged,
    this.initialNumber,
    this.contentPadding,
    this.editingController,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
  });
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: editingController,
      dropdownIconPosition: IconPosition.trailing,
      flagsButtonMargin: EdgeInsets.symmetric(horizontal: wp(2)),
      readOnly: readOnly ?? false,
      dropdownTextStyle:
          textMediumStyle.copyWith(color: Theme.of(context).primaryColorDark),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: "xxxxxxxxxx",
        counter: const SizedBox.shrink(),
        labelStyle:
            textMediumStyle.copyWith(color: Theme.of(context).primaryColorDark),
        contentPadding: contentPadding,
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
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              ),
            ),
      ),
      style: textSmallMediumStyle.copyWith(
          color: Theme.of(context).primaryColorDark),
      initialCountryCode: initialCountryCode,
      initialValue: initialNumber,
      onChanged: onNumberChanged,
      onCountryChanged: onCountryChanged,
    );
  }
}
