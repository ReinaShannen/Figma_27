import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'verify_number.dart';

class ChangeMobileViewModel {
  Country? selectedCountry;
  final TextEditingController phoneController = TextEditingController();
  String? phoneError;

  void init({
    required String? initialPhone,
  }) {
    selectedCountry = Country.parse('GB'); // Default UK

    if (initialPhone != null && initialPhone.isNotEmpty) {
      phoneController.text = initialPhone;
    }
  }

  void dispose() {
    phoneController.dispose();
  }

  void setCountry(Country country) {
    selectedCountry = country;
  }

  bool validatePhone() {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      phoneError = 'Please enter mobile number';
      return false;
    }

    if (phone.length < 8 || phone.length > 10) {
      phoneError = 'Please enter a valid number';
      return false;
    }

    phoneError = null;
    return true;
  }

  void goToVerify(BuildContext context) {
    final phone = phoneController.text.trim();

    final fullPhone =
        '+${selectedCountry?.phoneCode ?? '44'} $phone';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerifyNumberScreen(
          phoneNumber: fullPhone,
        ),
      ),
    );
  }
}
