import 'dart:async';
import 'package:flutter/material.dart';

class VerifyNumberViewModel {
  static const int resendTimeout = 60;

  int secondsRemaining = 0;
  Timer? timer;

  final TextEditingController otpController = TextEditingController();

  bool showOtpError = false;

  bool get canResend => secondsRemaining == 0;
  bool get isCountingDown => secondsRemaining > 0;

  void startResendTimer(VoidCallback onTick) {
    secondsRemaining = resendTimeout;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        secondsRemaining--;
        onTick();
      }
    });
  }

  void onResend(VoidCallback onUpdate) {
    if (!canResend) return;

    otpController.clear();
    startResendTimer(onUpdate);
    onUpdate();
  }

  bool validateOtp(VoidCallback onUpdate) {
    final otp = otpController.text.trim();

    if (otp.length != 4) {
      showOtpError = true;
      onUpdate();
      return false;
    }

    showOtpError = false;
    onUpdate();
    return true;
  }

  void dispose() {
    timer?.cancel();
    otpController.dispose();
  }
}
