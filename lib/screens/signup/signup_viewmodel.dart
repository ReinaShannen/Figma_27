import 'package:flutter/material.dart';
import '../verification/change_mobile.dart';


class SignupViewModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  bool isAccepted = false;

  String selectedCountryCode = '+44';
  String selectedFlag = '🇬🇧';

  final List<Map<String, String>> countries = [
    {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    {'name': 'United States', 'code': '+1', 'flag': '🇺🇸'},
  ];

  // ===== Navigation =====
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void goToChangeMobile(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    if (!isAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept Terms & Privacy Policy'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeMobileScreen(
          initialPhone: phoneController.text.trim(),
        ),
      ),
    );
  }

  // ===== Country Picker =====
  void selectCountry({
    required String code,
    required String flag,
  }) {
    selectedCountryCode = code;
    selectedFlag = flag;
  }
  //validation---------------

  String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) return null;

  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(value)) {
    return 'Name should contain only letters';
  }

  if (value.trim().length < 2) {
    return 'Enter a valid name';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return null;

  final emailRegex =
      RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null;
}


  void dispose() {
    phoneController.dispose();
  }
}
