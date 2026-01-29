import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/widgets/primary_button.dart';
import '../verification/change_mobile.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  bool isAccepted = false;

  String selectedCountryCode = '+44';
  String selectedFlag = '🇬🇧';

  final List<Map<String, String>> countries = [
    {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    {'name': 'United States', 'code': '+1', 'flag': '🇺🇸'},
  ];

  void _openCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      final isSelected =
                          country['code'] == selectedCountryCode;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCountryCode = country['code']!;
                            selectedFlag = country['flag']!;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          color: isSelected
                              ? const Color(0xFFF2F2F2)
                              : Colors.white,
                          child: Row(
                            children: [
                              Text(
                                country['flag']!,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      country['name']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      country['code']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check,
                                  color: Color(0xFFFF5421),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/back_arrow.svg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Let’s get started",
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1C2A39),
                  ),
                ),

                const SizedBox(height: 24),

                // NAME
                _textField(
                  hint: 'Enter Name',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\s]'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;

                    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                    if (!nameRegex.hasMatch(value)) return 'Name is invalid';
                    if (value.trim().length < 2) return 'Name is invalid';

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // EMAIL
                _textField(
                  hint: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;

                    final emailRegex =
                        RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // PHONE
                Row(
                  children: [
                    GestureDetector(
                      onTap: _openCountryPicker,
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color(0xFFECECEC)),
                        ),
                        child: Row(
                          children: [
                            Text(selectedFlag,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(selectedCountryCode),
                            const SizedBox(width: 4),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _textField(
                        controller: _phoneController,
                        hint: 'Phone number',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          if (value.length < 10) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Send verification code',
                  color: const Color(0xFFFF5421),
                  onTap: () {
                    if (!_formKey.currentState!.validate()) return;

                    if (!isAccepted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please accept Terms & Privacy Policy'),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeMobileScreen(
                          initialPhone: _phoneController.text.trim(),
                        ),
                      ),
                    );
                  },
                ),


                const SizedBox(height: 16),

                PrimaryButton(
                  text: 'Continue with Google',
                  color: const Color(0xFF1C2A39),
                  icon: Image.asset(
                    'assets/images/google.png',
                    width: 24,
                    height: 24,
                  ),
                  onTap: () {
                    // keep empty or wire later
                  },
                ),

                const SizedBox(height: 16),

                PrimaryButton(
                  text: 'Continue with Apple ID',
                  color: const Color(0xFF1C2A39),
                  icon: const Icon(
                    Icons.apple,
                    color: Colors.white,
                    size: 26,
                    weight: 26,
                  ),
                  onTap: () {
                    // keep empty or wire later
                  },
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    'Login instead?',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: isAccepted,
                    onChanged: (val) {
                      setState(() {
                        isAccepted = val ?? false;
                      });
                    },
                    activeColor: const Color(0xFFFF5421),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xFF6B6B6B),
                    ),
                    children: [
                      TextSpan(text: 'By creating an account, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _textField({
    required String hint,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECECEC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1C2A39)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}



//-------------------------------------------------//







// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../core/widgets/primary_button.dart';
// import '../verification/change_mobile.dart';
// import '../signup/signup_viewmodel.dart';



// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final SignupViewModel _viewModel = SignupViewModel();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();


//   bool isAccepted = false;

//   String selectedCountryCode = '+44';
//   String selectedFlag = '🇬🇧';

//   final List<Map<String, String>> countries = [
//     {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
//     {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
//     {'name': 'United States', 'code': '+1', 'flag': '🇺🇸'},
//   ];

// void _openCountryPicker() {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (_) {
//       return SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.7,
//           child: Column(
//             children: [
//               const SizedBox(height: 8),


//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Container(
//                           width: 40,
//                           height: 4,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         width: 32,
//                         height: 32,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFFF2F2F2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.close, size: 20,)
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Search field 
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Container(
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF7F7F7),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Country list
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: countries.length,
//                   itemBuilder: (context, index) {
//                     final country = countries[index];
//                     final isSelected =
//                         country['code'] == selectedCountryCode;

//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           selectedCountryCode = country['code']!;
//                           selectedFlag = country['flag']!;
//                         });
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 14,
//                         ),
//                         color: isSelected
//                             ? const Color(0xFFF2F2F2)
//                             : Colors.white,
//                         child: Row(
//                           children: [
//                             Text(
//                               country['flag']!,
//                               style: const TextStyle(fontSize: 22),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     country['name']!,
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Text(
//                                     country['code']!,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             if (isSelected)
//                               const Icon(
//                                 Icons.check,
//                                 color: Color(0xFFFF5421),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFC),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
          
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),

//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 44, // touch target (Figma)
//                     height: 44,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFF2F2F2), // Figma background
//                       shape: BoxShape.circle,
//                     ),
//                     alignment: Alignment.center,
//                     child: SvgPicture.asset(
//                       'assets/images/back_arrow.svg',
//                       width: 40,  // 👈 Figma arrow size
//                       height:40,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
                  

//                 const SizedBox(height: 24),

//                 const Text(
//                   "Let’s get started",
//                   style: TextStyle(
//                     fontFamily: 'RedHatDisplay',
//                     fontSize: 32,
//                     fontWeight: FontWeight.w800,
//                     color: Color(0xFF1C2A39),
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // NAME
//                 _textField(
//                   hint: 'Enter Name',
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(
//                       RegExp(r'[a-zA-Z\s]'),
//                     ),
//                   ],
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return null; // don’t show error initially
//                       }

//                       final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
//                       if (!nameRegex.hasMatch(value)) {
//                         return 'Name is invalid';
//                       }

//                       if (value.trim().length < 2) {
//                         return 'Name is invalid';
//                       }

//                       return null;
//                     },

//                 ),

//                 const SizedBox(height: 16),

//                 // EMAIL
//                 _textField(
//                   hint: 'Enter Email',
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return null;
//                     }

//                     final emailRegex =
//                         RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

//                     if (!emailRegex.hasMatch(value)) {
//                       return 'Enter a valid email address';
//                     }

//                     return null;
//                   },


//                 ),

//                 const SizedBox(height: 16),

//                 // PHONE ROW
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: _openCountryPicker,
//                       child: Container(
//                         height: 56,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border:
//                               Border.all(color: const Color(0xFFECECEC)),
//                         ),
//                         child: Row(
//                           children: [
//                             Text(selectedFlag, style: const TextStyle(fontSize: 20)),
//                             const SizedBox(width: 8),
//                             Text(selectedCountryCode),
//                             const SizedBox(width: 4),
//                             const Icon(Icons.keyboard_arrow_down),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _textField(
//                         controller: _phoneController, 
//                         hint: 'Phone number',
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(10),
//                         ],
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return null;
//                           }

//                           if (value.length < 10) {
//                             return 'Enter a valid 10-digit number';
//                           }

//                           return null;
//                         },

//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 24),
//             PrimaryButton(
//               text: 'Send verification code',
//               color: const Color(0xFFFF5421),
//               onTap: () {
//                 if (!_formKey.currentState!.validate()) return;

//                 if (!isAccepted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please accept Terms & Privacy Policy'),
//                     ),
//                   );
//                   return;
//                 }

//                 // ✅ Navigate to Change Mobile Number Screen
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => ChangeMobileScreen(
//       initialPhone: _phoneController.text.trim(),
//     ),
//   ),
// );

//               },
//             ),


//                             const SizedBox(height: 16),

//                 PrimaryButton(
//                   text: 'Continue with Google',
//                   color: const Color(0xFF1C2A39),
                  
//                   icon: Image.asset(
//                     'assets/images/google.png',
//                     width: 24,
//                     height: 24,
//                   ),
//                   onTap: () {},
//                 ),

//                 const SizedBox(height: 16),

//                 PrimaryButton(
//                   text: 'Continue with Apple ID',
//                   color: const Color(0xFF1C2A39),
//                   icon: const Icon(Icons.apple, color: Colors.white,size: 26,weight:26,),
//                   onTap: () {},
//                 ),

//                 const SizedBox(height: 24),

//                 Center(
//                   child: Text(
//                     'Login instead?',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 140),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
//           child:Row(
//             crossAxisAlignment: CrossAxisAlignment.start, // 🔥 aligns to text top
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 2), // fine-tune alignment
//                 child: SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: Checkbox(
//                     value: isAccepted,
//                     onChanged: (val) {
//                       setState(() {
//                         isAccepted = val ?? false;
//                       });
//                     },
//                     activeColor: const Color(0xFFFF5421),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     visualDensity: VisualDensity.compact, // 
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 12),

//               Expanded(
//                 child: RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                       fontFamily: 'WorkSans',
//                       fontSize: 14,          // matches Figma
//                       height: 1.4,           // better readability
//                       color: Color(0xFF6B6B6B),
//                     ),
//                     children: const [
//                       TextSpan(text: 'By creating an account, you agree to our '),
//                       TextSpan(
//                         text: 'Terms of Service',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                           color: Color(0xFF6B6B6B),
//                         ),
//                       ),
//                       TextSpan(text: ' and '),
//                       TextSpan(
//                         text: 'Privacy Policy',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                           color: Color(0xFF6B6B6B),
//                         ),
//                       ),
//                       TextSpan(text: '.'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )

//         ),
//       ),
//     );
//   }

//   static Widget _textField({
//     required String hint,
//     TextEditingController? controller,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//     List<TextInputFormatter>? inputFormatters,
//   }) {
//     return TextFormField(
//         controller: controller, 

//       keyboardType: keyboardType,
//       validator: validator,
//       inputFormatters: inputFormatters,
//       decoration: InputDecoration(
//         hintText: hint,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFECECEC)),
//         ),

//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF1C2A39)),
//         ),

//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.red),
//         ),

//         focusedErrorBorder: OutlineInputBorder( // ✅ FIX
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//       ),


//     );
//   }
// }