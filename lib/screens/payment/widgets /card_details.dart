import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  CardNumberInputFormatter({this.maxDigits = 16});

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

class CardDetailsSection extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final TextEditingController nameController;
  final String? cardNumberError;
  final String? expiryError;
  final String? cvvError;
  final String? nameError;

  const CardDetailsSection({
    super.key,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.nameController,
    this.cardNumberError,
    this.expiryError,
    this.cvvError,
    this.nameError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// CARD NUMBER LABEL
        const Text(
          'Card number',

          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 13,
            color: Color(0xFF6B6B6B),
          ),
        ),
        const SizedBox(height: 8),

        /// GROUPED CARD DETAILS CONTAINER (FIGMA MATCH)
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  (cardNumberError != null ||
                      expiryError != null ||
                      cvvError != null)
                  ? const Color(0xFFFF5A1F)
                  : const Color(0xFFECECEC),
            ),
          ),
          child: Column(
            children: [
              /// CARD NUMBER FIELD
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter(maxDigits: 16),
                ],

                decoration: InputDecoration(
                  hintText: '1234 5678 9012 3456',
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(12, 16, 44, 16),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset(
                      'assets/images/cards.png',
                      width: 121,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              /// HORIZONTAL DIVIDER
              const Divider(
                height: 1,
                thickness: 0.8,
                color: Color(0xFFE7E7E7),
              ),

              /// MM/YY + CVV ROW
              Row(
                children: [
                  /// MM/YY
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      readOnly: true,
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year, now.month),
                          lastDate: DateTime(now.year + 15),
                        );

                        if (picked != null) {
                          expiryController.text =
                              '${picked.month.toString().padLeft(2, '0')}/${picked.year % 100}';
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'MM/YY',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  /// VERTICAL DIVIDER
                  Container(width: 1, height: 24, color: Color(0xFFE7E7E7)),

                  /// CVV
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      obscureText: true,
                      maxLength: 3,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: 'CVV',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (cardNumberError != null) ...[
          const SizedBox(height: 6),
          Text(
            cardNumberError!,
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 12,
              height: 1.35,
              color: Color(0xFFFF5A1F),
            ),
          ),
        ],
        if (expiryError != null || cvvError != null) ...[
          const SizedBox(height: 6),
          Text(
            expiryError ?? cvvError ?? '',
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 12,
              height: 1.35,
              color: Color(0xFFFF5A1F),
            ),
          ),
        ],

        const SizedBox(height: 16),

        /// CARDHOLDER NAME
        const Text(
          'Cardholder name',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 13,
            color: Color(0xFF6B6B6B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: nameController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
          ],

          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: _border(nameError != null),
            enabledBorder: _border(nameError != null),
          ),
        ),
        if (nameError != null) ...[
          const SizedBox(height: 6),
          Text(
            nameError!,
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 12,
              height: 1.35,
              color: Color(0xFFFF5A1F),
            ),
          ),
        ],
      ],
    );
  }

  static OutlineInputBorder _border(bool hasError) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: hasError ? const Color(0xFFFF5A1F) : const Color(0xFFECECEC),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CardDetailsSection extends StatelessWidget {
//   final TextEditingController cardNumberController;
//   final TextEditingController expiryController;
//   final TextEditingController cvvController;
//   final TextEditingController nameController;

//   const CardDetailsSection({
//     super.key,
//     required this.cardNumberController,
//     required this.expiryController,
//     required this.cvvController,
//     required this.nameController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Card number
//         const Text(
//           'Card number',
//           style: TextStyle(
//             fontFamily: 'WorkSans',
//             fontSize: 13,
//             color: Color(0xFF6B6B6B),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: cardNumberController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             hintText: '1237 3543 5325 23',
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             border: _border(),
//             enabledBorder: _border(),
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//             Image.asset(
//               'assets/images/cards.png',
//               width: 55,
//               height: 60,
//               fit: BoxFit.contain,
//             ),

//               ],
//             ),
//           ),
//         ),

//         const SizedBox(height: 16),

//         /// MM/YY + CVV
//         Row(
//           children: [
//             Expanded(
//               child: _ExpiryField(controller: expiryController),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _CvvField(controller: cvvController),
//             ),
//           ],
//         ),

//         const SizedBox(height: 16),

//         /// Cardholder name
//         const Text(
//           'Cardholder name',
//           style: TextStyle(
//             fontFamily: 'WorkSans',
//             fontSize: 13,
//             color: Color(0xFF6B6B6B),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: nameController,
//           textCapitalization: TextCapitalization.words,
//           decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             border: _border(),
//             enabledBorder: _border(),
//           ),
//         ),
//       ],
//     );
//   }

//   static OutlineInputBorder _border() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: const BorderSide(color: Color(0xFFECECEC)),
//     );
//   }
// }

// class _ExpiryField extends StatelessWidget {
//   final TextEditingController controller;

//   const _ExpiryField({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'MM/YY',
//           style: TextStyle(
//             fontFamily: 'WorkSans',
//             fontSize: 13,
//             color: Color(0xFF6B6B6B),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           readOnly: true,
//           onTap: () async {
//             final now = DateTime.now();
//             final picked = await showDatePicker(
//               context: context,
//               initialDate: now,
//               firstDate: DateTime(now.year, now.month),
//               lastDate: DateTime(now.year + 15),
//             );

//             if (picked != null) {
//               controller.text =
//                   '${picked.month.toString().padLeft(2, '0')}/${picked.year % 100}';
//             }
//           },
//           decoration: InputDecoration(
//             hintText: 'MM/YY',
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             border: CardDetailsSection._border(),
//             enabledBorder: CardDetailsSection._border(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _CvvField extends StatelessWidget {
//   final TextEditingController controller;

//   const _CvvField({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'CVV',
//           style: TextStyle(
//             fontFamily: 'WorkSans',
//             fontSize: 13,
//             color: Color(0xFF6B6B6B),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           keyboardType: TextInputType.number,
//           obscureText: true,
//           maxLength: 4,
//           decoration: InputDecoration(
//             counterText: '',
//             hintText: 'CVV',
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             border: CardDetailsSection._border(),
//             enabledBorder: CardDetailsSection._border(),
//           ),
//         ),
//       ],
//     );
//   }
// }
