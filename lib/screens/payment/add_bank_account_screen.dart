import 'package:flutter/material.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/app_texfield.dart';

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
                    _formKey.currentState?.validate();
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
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Account holder name is required';
                    final nameRegex = RegExp(r'^[a-zA-Z\\s]+$');
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
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Sort code is required';
                    final cleaned = text.replaceAll('-', '');
                    if (!RegExp(r'^\\d{6}$').hasMatch(cleaned)) {
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
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) return 'Account number is required';
                    if (!RegExp(r'^\\d{8}$').hasMatch(text)) {
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
