import 'package:flutter/material.dart';
import 'verified_card_screen.dart';

class VerifyingCardScreen extends StatefulWidget {
  const VerifyingCardScreen({super.key});

  @override
  State<VerifyingCardScreen> createState() => _VerifyingCardScreenState();
}

class _VerifyingCardScreenState extends State<VerifyingCardScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VerifiedCardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: _VerifyingContent(),
        ),
      ),
    );
  }
}

class _VerifyingContent extends StatelessWidget {
  const _VerifyingContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF5A1F)),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Verifying your card',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: Color(0xFF1C2A39),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'It’ll only take a few seconds...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 13,
            height: 1.4,
            color: Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}
