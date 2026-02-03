// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:figma_proj/screens/verification/change_mobile_viewmodel.dart';

// class AppTextField extends StatelessWidget {
//   final String hint;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? errorText; // ✅ ADD THIS

//   const AppTextField({
//     super.key,
//     required this.hint,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.inputFormatters,
//     this.errorText, // ✅ ADD THIS
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       inputFormatters: inputFormatters,
//       decoration: InputDecoration(
//         isDense: true,
//         filled: true,
//         fillColor: Colors.white,

//         hintText: hint,
//         hintStyle: const TextStyle(
//           color: Color(0xFF9E9E9E),
//         ),

//         errorText: errorText, 

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFECECEC)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFECECEC)),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.red),
//         ),

//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 16,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  // 🔹 NEW (optional)
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;


  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.errorText,

    this.obscureText = false, // default false
    this.onToggleVisibility,
    this.suffixIcon,
      this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      onChanged: onChanged,


      style: const TextStyle(
        fontFamily: 'WorkSans',
        fontSize: 14,
      ),

      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,

        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 13,
          color: Color(0xFF9E9E9E),
        ),

        errorText: errorText,

        suffixIcon: suffixIcon ??
            (onToggleVisibility != null
                ? IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF6B6B6B),
                    ),
                  )
                : null),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFECECEC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFECECEC)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }
}

