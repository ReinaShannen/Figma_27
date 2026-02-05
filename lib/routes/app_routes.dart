import 'package:flutter/material.dart';

import '../screens/intro/intro_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/password /create_password_screen.dart';
import '../screens/payment/add_payment_card.dart';
import '../screens/payment/verifying_card_screen.dart';
import '../screens/payment/verified_card_screen.dart';
import '../screens/payment/add_bank_account_screen.dart';
import '../screens/home/hey_user_screen.dart';
import '../screens/groups/create_group_intro_screen.dart';
import '../screens/verification/change_mobile.dart';
import '../screens/verification/verify_number.dart';
import '../screens/splash /splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const intro = '/intro';
  static const signup = '/signup';
  static const createPassword = '/create-password';
  static const addPaymentCard = '/add-payment-card';
  static const verifyingCard = '/verifying-card';
  static const verifiedCard = '/verified-card';
  static const addBankAccount = '/add-bank-account';
  static const heyUser = '/hey-user';
  static const createGroupIntro = '/create-group-intro';
  static const changeMobile = '/change-mobile';
  static const verifyNumber = '/verify-number';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        intro: (_) => IntroScreen(),
        signup: (_) => const SignupScreen(),
        createPassword: (_) => const CreatePasswordScreen(),
        addPaymentCard: (_) => const AddPaymentCardScreen(),
        verifyingCard: (_) => const VerifyingCardScreen(),
        verifiedCard: (_) => const VerifiedCardScreen(),
        addBankAccount: (_) => AddBankAccountScreen(),
        heyUser: (_) => const HeyUserScreen(),
        createGroupIntro: (_) => const CreateGroupIntroScreen(),
        changeMobile: (_) => const ChangeMobileScreen(),
        verifyNumber: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return VerifyNumberScreen(
            phoneNumber: args is String ? args : '',
          );
        },
      };
}
