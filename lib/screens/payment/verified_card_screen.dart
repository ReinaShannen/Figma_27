import 'package:flutter/material.dart';
import 'add_bank_account_screen.dart';

class VerifiedCardScreen extends StatelessWidget {
  const VerifiedCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: _VerifiedContent(
            onComplete: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AddBankAccountScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VerifiedContent extends StatefulWidget {
  final VoidCallback onComplete;

  const _VerifiedContent({required this.onComplete});

  @override
  State<_VerifiedContent> createState() => _VerifiedContentState();
}

class _VerifiedContentState extends State<_VerifiedContent> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.check,
          size: 28,
          color: Color(0xFF2ECC71),
        ),
        SizedBox(height: 16),
        Text(
          'Verified',
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
          'Your card has been added.',
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
