import 'package:form_field_validator/form_field_validator.dart';

class FormValidations {
  String? requiredField(String? value, {String? errorText}) {
    if (value!.isEmpty) {
      return 'this_field_is_required';
    }
    return null;
  }

  PatternValidator nameValidateField() {
    return PatternValidator(r'^[a-zA-ZÇçĞğİıÖöŞşÜü\s]+$',
        errorText: "Please enter valid name");
  }

  PatternValidator passwordValidateField() {
    return PatternValidator(
        r'^(?=.*[a-zÇçĞğİıÖöŞşÜü])(?=.*[A-ZÇçĞğİıÖöŞşÜü])(?=.*\d)(?=.*[@$!%*?&^ÇçĞğİıÖöŞşÜü])[A-Za-zÇçĞğİıÖöŞşÜü\d@$!%*?&^]{8,}',
        errorText: "${"minimum 8 character"},"
            "${"one uppercase letter"},"
            "${"one lowercase letter"},"
            "${"one number and "},"
            "${"one special character"}");
  }

  MultiValidator validation({
    required String type,
    required MultiValidator multiValidator,
    required bool isRequired,
    String? errorText,
  }) {
    if (isRequired) {
      multiValidator.validators.add(
        RequiredValidator(errorText: errorText ?? "this field is required "),
      );
    }

    switch (type) {
      case "password":
        multiValidator.validators.add(passwordValidateField());
        break;
      case "email":
        multiValidator.validators
            .add(EmailValidator(errorText: "email is invalid"));
        break;
      case "name":
        multiValidator.validators.add(nameValidateField());
        break;
    }
    return multiValidator;
  }
}
