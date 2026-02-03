import 'package:flutter/material.dart';
import '../../core/widgets/back_button.dart';
import 'skip_bottomsheet.dart';
import 'verifying_card_screen.dart';
import '../payment/widgets /card_details.dart';
import '../payment/widgets /currency_selector.dart';

class AddPaymentCardScreen extends StatefulWidget {
  const AddPaymentCardScreen({super.key});

  @override
  State<AddPaymentCardScreen> createState() => _AddPaymentCardScreenState();
}

class _AddPaymentCardScreenState extends State<AddPaymentCardScreen> {
  final TextEditingController _cardNumberController =
      TextEditingController();
  final TextEditingController _expiryController =
      TextEditingController();
  final TextEditingController _cvvController =
      TextEditingController();
  final TextEditingController _nameController =
      TextEditingController();

  CurrencyType _selectedCurrency = CurrencyType.inr;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _showSkipBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const SkipAddCardBottomSheet(),
    );
  }
  String? _validateCardNumber(String value) {
  final digitsOnly = value.replaceAll(' ', '');

  if (digitsOnly.isEmpty) {
    return 'Card number is required';
  }
  if (digitsOnly.length < 15 || digitsOnly.length > 16) {
    return 'Enter a valid card number';
  }
  return null;
}

String? _validateExpiry(String value) {
  if (value.isEmpty) {
    return 'Expiry date is required';
  }

  final parts = value.split('/');
  if (parts.length != 2) return 'Invalid expiry date';

  final month = int.tryParse(parts[0]);
  final year = int.tryParse(parts[1]);

  if (month == null || year == null || month < 1 || month > 12) {
    return 'Invalid expiry date';
  }

  final now = DateTime.now();
  final expiry = DateTime(2000 + year, month + 1, 0);

  if (expiry.isBefore(DateTime(now.year, now.month, 1))) {
    return 'Card has expired';
  }

  return null;
}

String? _validateCvv(String value) {
  if (value.isEmpty) {
    return 'CVV is required';
  }
  if (value.length != 3) {
    return 'CVV must be 3 digits';
  }
  return null;
}
String? _validateCardholderName(String value) {
  if (value.trim().isEmpty) {
    return 'Name is required';
  }

  final nameRegex = RegExp(r'^[a-zA-Z ]+$');
  if (!nameRegex.hasMatch(value)) {
    return 'Enter a valid name';
  }

  if (value.trim().length < 2) {
    return 'Name is too short';
  }

  return null;
}
void _onAddCardPressed() {
  final cardError =
      _validateCardNumber(_cardNumberController.text);
  final expiryError =
      _validateExpiry(_expiryController.text);
  final cvvError =
      _validateCvv(_cvvController.text);
  final nameError =
      _validateCardholderName(_nameController.text);

  if (cardError == null &&
      expiryError == null &&
      cvvError == null &&
      nameError == null) {
    // ✅ All valid — proceed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VerifyingCardScreen()),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      /// 🔴 Bottom CTA
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
              onPressed: _onAddCardPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5A1F),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Add card',
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

      /// 🔽 Body
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonBackButton(),
              const SizedBox(height: 28),

              /// Header
              const Text(
                'Add your payment card',
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2A39),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'We’ll use your card to collect deposits automatically.',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  color: Color(0xFF6B6B6B),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),

              /// Currency selector (FIXED)
              CurrencySelector(
                selectedCurrency: _selectedCurrency,
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              /// Card details (FIXED – single source of truth)
              CardDetailsSection(
                cardNumberController: _cardNumberController,
                expiryController: _expiryController,
                cvvController: _cvvController,
                nameController: _nameController,
              ),

              const SizedBox(height: 24),

              /// Skip
              Center(
                child: GestureDetector(
                  onTap: _showSkipBottomSheet,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C2A39),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
        
      ),
    );
  }
}
