import 'package:flutter/material.dart';
import '../signup/signup_screen.dart';

class IntroViewModel {
  void onLogin(BuildContext context) {
    // TODO: Add login navigation later
  }

  void onCreateAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }
}
