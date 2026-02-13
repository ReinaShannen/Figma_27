import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PassTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool isValid;
  final String? errorText;
  final VoidCallback onToggleVisibility;
  final ValueChanged<String> onChanged;
  final TextStyle? errorStyle;
  final double errorTopSpacing;

  const PassTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.isValid,
    required this.onToggleVisibility,
    required this.onChanged,
    this.errorText,
    this.errorStyle,
    this.errorTopSpacing = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isValid
                  ? const Color(0xFF2ECC71)
                  : const Color(0xFFECECEC),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isValid)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SvgPicture.asset(
                        'assets/images/Tick.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: errorTopSpacing),
          Text(
            errorText!,
            style:
                errorStyle ?? const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ],
    );
  }
}
