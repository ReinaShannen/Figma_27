import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/app_texfield.dart';
import 'password_textfiled.dart';
import '../payment/add_payment_card.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  String? _passwordError;
  String? _confirmPasswordError;

  final RegExp _passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

  bool get _isPasswordValid =>
      _passwordRegex.hasMatch(_passwordController.text);

  bool get _isConfirmPasswordValid =>
      _confirmPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text == _passwordController.text;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    setState(() {
      _passwordError = _isPasswordValid
          ? null
          : 'Your password must be at least 8 characters long and include an uppercase letter, a number, and a special character.';

      _confirmPasswordError =
          _isConfirmPasswordValid ? null : 'Passwords do not match';
    });
if (_passwordError == null && _confirmPasswordError == null) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AddPaymentCardScreen(),
    ),
  );
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            8,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onNextPressed, // 👈 always enabled (Figma)
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A1F),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),

      /// ✅ SCROLLABLE CONTENT (NO OVERFLOW)
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const CommonBackButton(),
              const SizedBox(height: 24),

              const Text(
                'Create your password',
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2A39),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Your password must be at least 8 characters long and include an uppercase letter, a number, and a special character.',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  color: Color(0xFF6B6B6B),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),

              /// -------- PASSWORD --------
              const Text(
                'Password',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 13,
                  color: Color(0xFF6B6B6B),
                ),
              ),
              const SizedBox(height: 8),

              PassTextField(
              hint: 'Enter password',
              controller: _passwordController,
              obscureText: _hidePassword,
              isValid: _isPasswordValid,
              errorText: _passwordError,
              errorStyle: const TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12,
                height: 1.35,
                color: Color(0xFFB24B4B),
              ),
              onToggleVisibility: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              onChanged: (_) => setState(() {}),
            ),

              const SizedBox(height: 24),

              /// -------- RETYPE PASSWORD --------
              const Text(
                'Retype password',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 13,
                  color: Color(0xFF6B6B6B),
                ),
              ),
              const SizedBox(height: 8),

              PassTextField(
                hint: 'Retype password',
                controller: _confirmPasswordController,
                obscureText: _hideConfirmPassword,
                isValid: _isConfirmPasswordValid,
                errorText: _confirmPasswordError,
                errorStyle: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 12,
                  height: 1.35,
                  color: Color(0xFFB24B4B),
                ),
                onToggleVisibility: () {
                  setState(() {
                    _hideConfirmPassword = !_hideConfirmPassword;
                  });
                },
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
