


import 'package:flutter/cupertino.dart';
import 'package:flutter_app8/generated/l10n.dart';


class Validations {

  static String? validateEmail(String email,BuildContext context) {
    String? validateString = '';
    RegExp emailPattern = new RegExp("[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+");
    if (email.isEmpty) {
      validateString = S.of(context).emptyField;
    } else if (!emailPattern.hasMatch(email) || email.indexOf('@') != email.lastIndexOf('@')) {
        validateString = S.of(context).invEmail;
      } else {
        validateString = null;
      }

    return validateString;
  }
  static String? validateField(String value,BuildContext context) {
    String? validateString = '';

    if (value.trim().isEmpty) {
      validateString = S.of(context).emptyField;
    }  else {
        validateString = null;

      }
    return validateString;
    }



}
