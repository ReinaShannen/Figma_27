import 'package:flutter/material.dart';
import '../../core/widgets/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'change_mobile_viewmodel.dart';
import '../../core/widgets/app_texfield.dart';
import '../../core/widgets/back_button.dart';

class ChangeMobileScreen extends StatefulWidget {
  final String? initialPhone;

  const ChangeMobileScreen({
    super.key,
    this.initialPhone,
  });

  @override
  State<ChangeMobileScreen> createState() => _ChangeMobileScreenState();
}

class _ChangeMobileScreenState extends State<ChangeMobileScreen> {
  final ChangeMobileViewModel _viewModel = ChangeMobileViewModel();
  final _formKey = GlobalKey<FormState>();

int selectedCountryIndex = 0;
String selectedCountryCode = '+44';
String selectedFlagAsset = 'assets/images/UK.svg';

final List<Map<String, String>> countries = List.generate(6, (_) => {
  'name': 'United Kingdom',
  'code': '+44',
  'asset': 'assets/images/UK.svg',
});


  @override
  void initState() {
    super.initState();
    _viewModel.init(initialPhone: widget.initialPhone);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F5),



      // ======================
      // BODY 
      // ======================
      body: SafeArea(
        left: true,
        right: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const SizedBox(height: 12),
                  const CommonBackButton(),
                  const SizedBox(height: 24),
              const Text(
                'Change mobile number',
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: Color(0xFF1C2A39),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'For security, we’ll text you a one-time code to confirm this change.',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFF6B6B6B),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Country picker
                  GestureDetector(
                  onTap: () {
                    showCustomCountryPicker(
                      context: context,
                      countries: countries,
                      selectedIndex: selectedCountryIndex,
                      onSelect: (index, code, flagAsset) {
                        setState(() {
                          selectedCountryIndex = index;
                          selectedCountryCode = code;
                          selectedFlagAsset = flagAsset;
                        });
                      },
                    );
                  },

                    child: SizedBox(
                      height: 56,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFECECEC),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        selectedFlagAsset,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 6),
                      Text(selectedCountryCode),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),

                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: AppTextField(
                      hint: 'Enter mobile number',
                      controller: _viewModel.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        final phone = value?.trim() ?? '';
                        if (phone.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        if (phone.length < 8 || phone.length > 10) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40), // replaces Spacer safely
              ],
            ),
          ),
        ),
      ),

      // ======================
      // BOTTOM BUTTON 
      // ======================
bottomNavigationBar: SafeArea(
  top: false,
  child: AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
    padding: EdgeInsets.only(
      left: 32,
      right: 32,
      // ONLY keyboard height — SafeArea handles iPhone bottom inset
      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5A21),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _viewModel.goToVerify(context);
          }
        },
        child: const Text(
          'Change mobile number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ),
    ),
  ),
),
    );
  }
}





























// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'change_mobile_viewmodel.dart';
// import '../../core/widgets/app_texfield.dart';

// class ChangeMobileScreen extends StatefulWidget {
//   final String? initialPhone;

//   const ChangeMobileScreen({
//     super.key,
//     this.initialPhone,
//   });

//   @override
//   State<ChangeMobileScreen> createState() => _ChangeMobileScreenState();
// }

// class _ChangeMobileScreenState extends State<ChangeMobileScreen> {
//   final ChangeMobileViewModel _viewModel = ChangeMobileViewModel();

//   @override
//   void initState() {
//     super.initState();
//     _viewModel.init(initialPhone: widget.initialPhone);
//   }

//   @override
//   void dispose() {
//     _viewModel.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),

//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F5F5),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFF2F2F2),
//                 shape: BoxShape.circle,
//               ),
//               alignment: Alignment.center,
//               child: SvgPicture.asset(
//                 'assets/images/back_arrow.svg',
//                 width: 40,
//                 height: 40,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Change mobile number',
//               style: TextStyle(
//                 fontFamily: 'RedHatDisplay',
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 height: 1.4,
//                 color: Color(0xFF1C2A39),
//               ),
//             ),

//             const SizedBox(height: 8),

//             const Text(
//               'For security, we’ll text you a one-time code to confirm this change.',
//               style: TextStyle(
//                 fontFamily: 'WorkSans',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 height: 1.5,
//                 color: Color(0xFF6B6B6B),
//               ),
//             ),

//             const SizedBox(height: 24),

//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Country picker
//                 GestureDetector(
//                   onTap: () {
//                     showCountryPicker(
//                       context: context,
//                       showPhoneCode: true,
//                       showSearch: true,
//                       onSelect: (Country country) {
//                         setState(() {
//                           _viewModel.setCountry(country);
//                         });
//                       },
//                     );
//                   },
//                   child: SizedBox(
//                     height: 56,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                           color: const Color(0xFFECECEC),
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(_viewModel.selectedCountry?.flagEmoji ?? '🇬🇧'),
//                           const SizedBox(width: 6),
//                           Text(
//                             '+${_viewModel.selectedCountry?.phoneCode ?? '44'}',
//                           ),
//                           const Icon(Icons.keyboard_arrow_down, size: 18),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

// Expanded(
//   child: AppTextField(
//     hint: 'Enter mobile number',
//     controller: _viewModel.phoneController,
//     keyboardType: TextInputType.phone,
//     inputFormatters: [
//       FilteringTextInputFormatter.digitsOnly,
//       LengthLimitingTextInputFormatter(10),
//     ],
//     errorText: _viewModel.phoneError,
//   ),
// ),

//               ],
//             ),

//             const Spacer(),

//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFF5A21),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     if (_viewModel.validatePhone()) {
//                       _viewModel.goToVerify(context);
//                     }
//                   });
//                 },
//                 child: const Text(
//                   'Change mobile number',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     height: 1.2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'verify_number.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';


// class ChangeMobileScreen extends StatefulWidget {
//   final String? initialPhone; 
//   const ChangeMobileScreen({super.key,this.initialPhone,});

//   @override
//   State<ChangeMobileScreen> createState() => _ChangeMobileScreenState();
// }

// class _ChangeMobileScreenState extends State<ChangeMobileScreen> {
//   Country? _selectedCountry;
//   final TextEditingController _phoneController = TextEditingController();
//   String? _phoneError;

// @override
// void initState() {
//   super.initState();
//   _selectedCountry = Country.parse('GB'); // Default UK

//   if (widget.initialPhone != null &&
//       widget.initialPhone!.isNotEmpty) {
//     _phoneController.text = widget.initialPhone!;
//   }
// }


//   // // ✅ ADDED: dispose controller (logic only)
//   // @override
//   // void dispose() {
//   //   _phoneController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//    appBar: AppBar(
//   backgroundColor: const Color(0xFFF5F5F5),
//   elevation: 0,
//   automaticallyImplyLeading: false, // 🚫 remove system back arrow
//   leading: Padding(
//     padding: const EdgeInsets.only(left: 8),
//     child: GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Container(
//         width: 44,
//         height: 44,
//         decoration: const BoxDecoration(
//           color: Color(0xFFF2F2F2),
//           shape: BoxShape.circle,
//         ),
//         alignment: Alignment.center,
//         child: SvgPicture.asset(
//           'assets/images/back_arrow.svg',
//           width: 40,
//           height: 40,
//           fit: BoxFit.contain,
//         ),
//       ),
//     ),
//   ),
// ),

//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Change mobile number',
//               style: TextStyle(
//                 fontFamily: 'RedHatDisplay',
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 height: 1.4, 
//                 color: Color(0xFF1C2A39),
//               ),
//             ),

//             const SizedBox(height: 8),

//             const Text(
//               'For security, we’ll text you a one-time code to confirm this change.',
//               style: TextStyle(
//                 fontFamily: 'WorkSans',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 height: 1.5, // 150%
//                 color: Color(0xFF6B6B6B),
//               ),
//             ),

//             const SizedBox(height: 24),

//             Row(
//               children: [
//                 /// Country picker
//                 GestureDetector(
//                   onTap: () {
//                     showCountryPicker(
//                       context: context,
//                       showPhoneCode: true,
//                       showSearch: true,
//                       onSelect: (Country country) {
//                         setState(() {
//                           _selectedCountry = country;
//                         });
//                       },
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(_selectedCountry?.flagEmoji ?? '🇬🇧'),
//                         const SizedBox(width: 6),
//                         Text('+${_selectedCountry?.phoneCode ?? '44'}'),
//                         const Icon(Icons.keyboard_arrow_down, size: 18),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 /// Phone input
//                 Expanded(
//                   child: TextField(
//                     controller: _phoneController, 
//                     keyboardType: TextInputType.phone,
//                        inputFormatters:  [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(10),
//                       ],

                    
//                     decoration: InputDecoration(
//                       filled: true,

//                       fillColor: Colors.white,
//                       hintText: 'Enter mobile number',
//                       errorText: _phoneError, 
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const Spacer(),

//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFF5A21),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//  onPressed: () {
//   final phone = _phoneController.text.trim();

//   if (phone.isEmpty) {
//     setState(() => _phoneError = 'Please enter mobile number');
//     return;
//   }

//   if (phone.length < 8) {
//     setState(() => _phoneError = 'Please enter a valid mobile number');
//     return;
//   }
//     if (phone.length >10) {
//     setState(() => _phoneError = 'Please enter a valid mobile number');
//     return;
//   }

//   setState(() => _phoneError = null);

//   // ✅ ADD THIS
//   final fullPhone =
//       '+${_selectedCountry?.phoneCode ?? '44'} $phone';
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => VerifyNumberScreen(
//       phoneNumber: fullPhone,
//     ),
//   ),
// );

// },

//                 child: const Text(
//                   'Change mobile number',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     height: 1.2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
