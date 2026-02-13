import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/app_texfield.dart';
import '../home/hey_user_screen.dart';

class SortCodeInputFormatter extends TextInputFormatter {
  SortCodeInputFormatter({this.maxDigits = 6});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsBeforeCursor = _countDigits(
      newValue.text.substring(
        0,
        newValue.selection.baseOffset.clamp(0, newValue.text.length),
      ),
    );
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final clipped = digitsOnly.length > maxDigits
        ? digitsOnly.substring(0, maxDigits)
        : digitsOnly;
    final formatted = _groupByTwoWithDashes(clipped);

    final newCursor = _cursorForDigitIndex(formatted, digitsBeforeCursor);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }

  static int _countDigits(String text) {
    var count = 0;
    for (final codeUnit in text.codeUnits) {
      if (codeUnit >= 48 && codeUnit <= 57) count++;
    }
    return count;
  }

  static String _groupByTwoWithDashes(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i != 0 && i % 2 == 0) buffer.write('-');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static int _cursorForDigitIndex(String formatted, int digitIndex) {
    if (digitIndex <= 0) return 0;
    var digitsSeen = 0;
    for (var i = 0; i < formatted.length; i++) {
      final c = formatted.codeUnitAt(i);
      if (c >= 48 && c <= 57) {
        digitsSeen++;
        if (digitsSeen >= digitIndex) return i + 1;
      }
    }
    return formatted.length;
  }
}

class AccountNumberInputFormatter extends TextInputFormatter {
  AccountNumberInputFormatter({this.maxDigits = 8});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsBeforeCursor = _countDigits(
      newValue.text.substring(
        0,
        newValue.selection.baseOffset.clamp(0, newValue.text.length),
      ),
    );
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final clipped = digitsOnly.length > maxDigits
        ? digitsOnly.substring(0, maxDigits)
        : digitsOnly;
    final formatted = _groupIntoFours(clipped);

    final newCursor = _cursorForDigitIndex(formatted, digitsBeforeCursor);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }

  static int _countDigits(String text) {
    var count = 0;
    for (final codeUnit in text.codeUnits) {
      if (codeUnit >= 48 && codeUnit <= 57) count++;
    }
    return count;
  }

  static String _groupIntoFours(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static int _cursorForDigitIndex(String formatted, int digitIndex) {
    if (digitIndex <= 0) return 0;
    var digitsSeen = 0;
    for (var i = 0; i < formatted.length; i++) {
      final c = formatted.codeUnitAt(i);
      if (c >= 48 && c <= 57) {
        digitsSeen++;
        if (digitsSeen >= digitIndex) return i + 1;
      }
    }
    return formatted.length;
  }
}

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _sortCodeController.dispose();
    _accountNumberController.dispose();
    super.dispose();
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
            12,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _submitted = true);
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HeyUserScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A1F),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Save bank details',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonBackButton(),
                const SizedBox(height: 16),
                const Text(
                  'Add bank account',
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: Color(0xFF1C2A39),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE7E7E7)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.account_balance_outlined,
                          size: 16,
                          color: Color(0xFF4A5565),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Why do we need this?',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: Color(0xFF101828),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your bank details are used to send you money when your group makes payouts or when you leave a group.',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                height: 1.45,
                                color: Color(0xFF4A5565),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Account holder name',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 13,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  hint: '',
                  controller: _nameController,
                  onChanged: (_) {
                    if (_submitted) _formKey.currentState?.validate();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Account holder name is required';
                    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                    if (!nameRegex.hasMatch(text)) {
                      return 'Enter a valid name';
                    }
                    if (text.length < 2) return 'Name is too short';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sort code',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 13,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  hint: '',
                  controller: _sortCodeController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    if (_submitted) _formKey.currentState?.validate();
                  },
                  inputFormatters: [SortCodeInputFormatter(maxDigits: 6)],
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Sort code is required';
                    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
                    if (!RegExp(r'^\d{6}$').hasMatch(cleaned)) {
                      return 'Enter a valid sort code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Number',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 13,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  hint: '',
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    if (_submitted) _formKey.currentState?.validate();
                  },
                  inputFormatters: [AccountNumberInputFormatter(maxDigits: 8)],
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Account number is required';
                    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
                    if (!RegExp(r'^\d{8}$').hasMatch(cleaned)) {
                      return 'Enter a valid account number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
