import 'package:flutter/material.dart';

class Validator {
  static bool passwordValidate(String pass) {
    String password = pass.trim();
    if (password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  static String? validateAnotherField(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Please enter This field";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "This field is required";
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (value.length > 50) {
      return "Please enter a valid name";
    } else if (!RegExp(
      r'^[\u0621-\u064A\u0660-\u0669a-zA-Z0-9\s]+$',
    ).hasMatch(value)) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Please enter password";
    } else {
      bool result = passwordValidate(value);
      if (result) {
        return null;
      } else {
        return "S.of(context).your_pass_should_contain_capital_small_special";
      }
    }
  }

  static String? validatePhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Please enter phone number";
    }

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    final egyptPhoneRegex = RegExp(r'^((\+20)|(0020))?01[0125][0-9]{8}$');

    if (!egyptPhoneRegex.hasMatch(cleanedValue)) {
      return "Please enter a valid Egyptian phone number";
    }

    return null;
  }
}
