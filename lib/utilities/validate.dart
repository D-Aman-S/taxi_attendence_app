import 'package:email_validator/email_validator.dart';

class Validate {
  static String? email(String? value) {
    if (!EmailValidator.validate(value!) || value == "") {
      return "Invalid email";
    } else {
      return null;
    }
  }

  static String? notEmpty(String? value) {
    if (value == "") {
      return "Please enter value!";
    } else {
      return null;
    }
  }

  static String? phoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
