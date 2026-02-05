import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../splash /verifying_screen.dart';
import 'verify_number_viewmodel.dart';
import '../../core/widgets/back_button.dart';

class VerifyNumberScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyNumberScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final VerifyNumberViewModel _viewModel = VerifyNumberViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }


//   Widget _buildOtpFields(BuildContext context) {
//   final isLandscape =
//       MediaQuery.of(context).orientation == Orientation.landscape;

//   // 🎯 Explicit sizes per orientation
//   final double fieldWidth = isLandscape ? 44 : 72;
//   final double fieldHeight = isLandscape ? 48 : 58;
//   final double fieldFontSize = isLandscape ? 16 : 18;

//   return Center(
//     child: PinCodeTextField(
//       appContext: context,
//       length: 4,
//       controller: _viewModel.otpController,

//       // 🚨 IMPORTANT: prevent controller disposal issues
//       autoDisposeControllers: false,

//       keyboardType: TextInputType.number,
//       autoFocus: true,
//       animationType: AnimationType.fade,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//       ],
//       textStyle: TextStyle(
//         color: Colors.black,
//         fontSize: fieldFontSize,
//         fontWeight: FontWeight.w600,
//       ),
//       onChanged: (_) {},
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(9),
//         fieldHeight: fieldHeight,
//         fieldWidth: fieldWidth,
//         activeFillColor: Colors.white,
//         inactiveFillColor: Colors.white,
//         selectedFillColor: Colors.white,
//         inactiveColor: const Color(0xFFECECEC),
//         activeColor:const Color(0xFFECECEC) ,
//         selectedColor: const Color(0xFFECECEC),
//       ),
//       enableActiveFill: true,
//     ),
//   );
// }




  @override
  Widget build(BuildContext context) {
    final Color borderColor = _viewModel.showOtpError
        ? Colors.red
        : _viewModel.isCountingDown
            ? const Color(0xFFFF5A21)
            : const Color(0xFFECECEC);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F5),



body: SafeArea(
  left: true,
  right: true,
  child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    const SizedBox(height: 12),
    const CommonBackButton(),
    const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Verify your number\n\n',
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                  color: Color(0xFF1C2A39),
                ),
              ),
              const TextSpan(
                text: 'Enter the 4-digit code we sent to\n',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFF6B6B6B),
                ),
              ),
              TextSpan(
                text: widget.phoneNumber,
                style: const TextStyle(
                  fontFamily: 'WorkSans bold',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
              ),
            ],
          ),
          ),
        ),

        const SizedBox(height: 24),


OrientationBuilder(
  builder: (context, orientation) {
    final isLandscape = orientation == Orientation.landscape;

    final double fieldHeight = isLandscape ? 44 : 58;
    final double gap = isLandscape ? 12 : 24;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final fieldWidth =
              ((availableWidth - (3 * gap)) / 4).clamp(40.0, 80.0);

          return PinCodeTextField(
          appContext: context,
          length: 4,
          controller: _viewModel.otpController,
          autoDisposeControllers: false,
          keyboardType: TextInputType.number,
          autoFocus: true,
          animationType: AnimationType.fade,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: isLandscape ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (_) {},

          separatorBuilder: (context, index) =>
              SizedBox(width: gap),

          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(9),
            fieldHeight: fieldHeight,
            fieldWidth: fieldWidth,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveColor: borderColor,
            activeColor: borderColor,
            selectedColor: borderColor,
          ),
          enableActiveFill: true,
          );
        },
      ),
    );
  },
),

const SizedBox(height: 16),

//         // ===== SAFE OTP WIDTH =====
// Builder(
//   builder: (context) {
//     final media = MediaQuery.of(context);
//     final isLandscape =
//         media.orientation == Orientation.landscape;

//     // Tighter sizing for landscape
//     final safeHorizontal = media.padding.horizontal;
//     final availableWidth =
//         media.size.width - safeHorizontal - 40;

//     final rawFieldWidth =
//         isLandscape
//             ? (availableWidth - 12) / 4 // 🔥 tighter in landscape
//             : (availableWidth - 24) / 4;

//     final fieldWidth = rawFieldWidth.clamp(
//       isLandscape ? 36.0 : 44.0,  // 🔥 smaller min in landscape
//       isLandscape ? 60.0 : 80.0,
//     );

//     return PinCodeTextField(
//       appContext: context,
//       length: 4,
//       controller: _viewModel.otpController,
//       keyboardType: TextInputType.number,
//       autoFocus: true,
//       animationType: AnimationType.fade,
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//       ],
//       textStyle: const TextStyle(
//         color: Colors.black,
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//       ),
//       onChanged: (_) {},

//       // 🔥 KEY: tighter gap between boxes
//       separatorBuilder: (context, index) =>
//           SizedBox(width: isLandscape ? 6 : 10),

//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(9),
//         fieldHeight: 56,
//         fieldWidth: fieldWidth,
//         activeFillColor: Colors.white,
//         inactiveFillColor: Colors.white,
//         selectedFillColor: Colors.white,
//         inactiveColor: borderColor,
//         activeColor: borderColor,
//         selectedColor: borderColor,
//       ),
//       enableActiveFill: true,
//     );
//   },
// ),

        const SizedBox(height: 16),

        Center(
          child: TextButton(
            onPressed: _viewModel.canResend
                ? () => _viewModel.onResend(() => setState(() {}))
                : null,
            child: Text(
              _viewModel.canResend
                  ? 'Resend code'
                  : 'Resend code in 00:${_viewModel.secondsRemaining.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontFamily: 'WorkSans SemiBold',
                color: _viewModel.canResend
                    ? const Color(0xFF1C2A39)
                    : const Color(0xFFFF5A21),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const SizedBox(height: 40), // replaces Spacer safely
      ],
    ),
  ),
),



     
bottomNavigationBar: SafeArea(
  top: false,
  child: AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
    padding: EdgeInsets.only(
      left: 20,
      right: 20,
      // Only keyboard height — SafeArea handles iPhone inset
      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5A21),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        onPressed: () {
          final isValid =
              _viewModel.validateOtp(() => setState(() {}));

          if (!isValid) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const VerifyingScreen(),
            ),
          );
        },
        child: const Text(
          'verify phone number',
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





// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../splash /verifying_screen.dart'; 

// class VerifyNumberScreen extends StatefulWidget {
//   final String phoneNumber;
//   const VerifyNumberScreen({
//     super.key,
//     required this.phoneNumber,
//   });

//   @override
//   State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
// }

// class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
//   static const int _resendTimeout = 60;

//   int _secondsRemaining = 0;
//   Timer? _timer;
//   bool _showOtpError = false;


//   final TextEditingController _otpController = TextEditingController();



//   bool get _canResend => _secondsRemaining == 0;
//   bool get _isCountingDown => _secondsRemaining > 0;

//   void _startResendTimer() {
//     _secondsRemaining = _resendTimeout;
//     _timer?.cancel();

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsRemaining == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _secondsRemaining--;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _onResend() {
//     if (!_canResend) return;

//     setState(() {
//       _otpController.clear();
//     });

//     _startResendTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
// final Color borderColor = _showOtpError
//     ? Colors.red // 🔴 validation error
//     : _isCountingDown
//         ? const Color(0xFFFF5A21)
//         : const Color(0xFFECECEC);


//     return Scaffold(
//      backgroundColor: const Color(0xFFF5F5F5),

//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5F5F5),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
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
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         const TextSpan(
//                           text: 'Verify your number\n\n',
//                           style: TextStyle(
//                             fontFamily: 'RedHatDisplay',
//                             fontSize: 28,
//                             fontWeight: FontWeight.w800,
//                             height: 1.0,
//                             color: Color(0xFF1C2A39),
//                           ),
//                         ),
//                         const TextSpan(
//                           text: 'Enter the 4-digit code we sent to\n',
//                           style: TextStyle(
//                             fontFamily: 'WorkSans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             height: 1.5,
//                             color: Color(0xFF6B6B6B),
//                           ),
//                         ),
                        
//                         TextSpan(
//                           text: widget.phoneNumber,
//                           style: const TextStyle(
//                             fontFamily: 'WorkSans bold',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             height: 1.5,
//                             color: Color.fromARGB(255, 18, 18, 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 const SizedBox(height: 32),



//                   PinCodeTextField(
//                     appContext: context,
//                     length: 4,
//                     controller: _otpController,
//                     keyboardType: TextInputType.number,
//                     autoFocus: true,
//                     animationType: AnimationType.fade,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     textStyle: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     onChanged: (value) {},
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(9),
//                       fieldHeight: 58,
//                       fieldWidth: 60,
//                       activeFillColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                       inactiveColor: borderColor,
//                       activeColor: borderColor,
//                       selectedColor: borderColor,
//                     ),
//                     enableActiveFill: true,
//                   ),

//                   const SizedBox(height: 16),

//                   Center(
//                     child: TextButton(
//                       onPressed: _canResend ? _onResend : null,
//                       child: Text(
//                         _canResend
//                             ? 'Resend code'
//                             : 'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
//                         style: TextStyle(
//                           fontFamily: 'WorkSans SemiBold',
//                           color: _canResend
//                               ? const Color(0xFF1C2A39)
//                               : const Color(0xFFFF5A21),
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const Spacer(),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF5A21),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(26),
//                         ),
//                       ),
// onPressed: () {
//   final otp = _otpController.text.trim();

//   if (otp.length != 4) {
//     setState(() {
//       _showOtpError = true; // 🔴 trigger red borders
//     });
//     return;
//   }

//   setState(() {
//     _showOtpError = false;
//   });

//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => const VerifyingScreen(),
//     ),
//   );
// },


//                       child: const Text(
//                         'verify phone number',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }







// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../screens/splash /verifying_screen.dart'; 

// class VerifyNumberScreen extends StatefulWidget {
//   final String phoneNumber;
//   const VerifyNumberScreen({
//     super.key,
//     required this.phoneNumber,
//   });

//   @override
//   State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
// }

// class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
//   static const int _resendTimeout = 60;

//   int _secondsRemaining = 0;
//   Timer? _timer;

//   final TextEditingController _otpController = TextEditingController();

//   bool _isVerifying = false;

//   bool get _canResend => _secondsRemaining == 0;
//   bool get _isCountingDown => _secondsRemaining > 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _startResendTimer() {
//     _secondsRemaining = _resendTimeout;
//     _timer?.cancel();

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsRemaining == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _secondsRemaining--;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _onResend() {
//     if (!_canResend) return;

//     setState(() {
//       _otpController.clear();
//     });

//     _startResendTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color borderColor = _isCountingDown
//         ? const Color(0xFFFF5A21)
//         : const Color(0xFFECECEC);

//     return Scaffold(
//       backgroundColor: _isVerifying ? Colors.white : const Color(0xFFF5F5F5),

//       appBar: AppBar(
//         backgroundColor: _isVerifying ? Colors.white : const Color(0xFFF5F5F5),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: GestureDetector(
//             onTap: () {
//               if (_isVerifying) {
//                 setState(() {
//                   _isVerifying = false; // ✅ back to OTP (NO POP)
//                 });
//               } else {
//                 Navigator.pop(context);
//               }
//             },
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: _isVerifying
//                     ? Colors.transparent
//                     : const Color(0xFFF2F2F2),
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

//       // ✅ USE SEPARATE FILE WIDGET
//       body: _isVerifying
//           ? const VerifyingScreen()
//           : Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         const TextSpan(
//                           text: 'Verify your number\n\n',
//                           style: TextStyle(
//                             fontFamily: 'RedHatDisplay',
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             height: 1.4,
//                             color: Color(0xFF1C2A39),
//                           ),
//                         ),
//                         const TextSpan(
//                           text: 'Enter the 4-digit code we sent to\n',
//                           style: TextStyle(
//                             fontFamily: 'WorkSans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             height: 1.5,
//                             color: Color(0xFF6B6B6B),
//                           ),
//                         ),
//                         TextSpan(
//                           text: widget.phoneNumber,
//                           style: const TextStyle(
//                             fontFamily: 'WorkSans bold',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             height: 1.5,
//                             color: Color.fromARGB(255, 18, 18, 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   PinCodeTextField(
//                     appContext: context,
//                     length: 4,
//                     controller: _otpController,
//                     keyboardType: TextInputType.number,
//                     autoFocus: true,
//                     animationType: AnimationType.fade,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     textStyle: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     onChanged: (value) {},
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(9),
//                       fieldHeight: 58,
//                       fieldWidth: 60,
//                       activeFillColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                       inactiveColor: borderColor,
//                       activeColor: borderColor,
//                       selectedColor: borderColor,
//                     ),
//                     enableActiveFill: true,
//                   ),

//                   const SizedBox(height: 16),

//                   Center(
//                     child: TextButton(
//                       onPressed: _canResend ? _onResend : null,
//                       child: Text(
//                         _canResend
//                             ? 'Resend code'
//                             : 'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
//                         style: TextStyle(
//                           fontFamily: 'WorkSans SemiBold',
//                           color: _canResend
//                               ? const Color(0xFF1C2A39)
//                               : const Color(0xFFFF5A21),
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const Spacer(),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF5A21),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(26),
//                         ),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isVerifying = true;
//                         });
//                       },
//                       child: const Text(
//                         'verify phone number',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// //   Widget _buildVerifyingScreen() {
// //     return Center(
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: const [
// //           CircularProgressIndicator(color: Color(0xFFFF5A21)),
// //           SizedBox(height: 12),
// //           Text(
// //             'Verifying',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontFamily: 'WorkSans SemiBold',
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               height: 1.3,
// //               color: Color(0xFF1C2A39),
// //             ),
// //           ),
// //           SizedBox(height: 6),
// //           Text(
// //             'It only takes few seconds to verify...',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontFamily: 'WorkSans',
// //               fontSize: 13,
// //               fontWeight: FontWeight.w400,
// //               height: 1.5,
// //               color: Color(0xFF6B6B6B),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



















// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:pin_code_fields/pin_code_fields.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_svg/flutter_svg.dart';

// // class VerifyNumberScreen extends StatefulWidget {
// //   final String phoneNumber;
// //   const VerifyNumberScreen({
// //     super.key,
// //     required this.phoneNumber,
// //   });

// //   @override
// //   State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
// // }

// // class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
// //   static const int _resendTimeout = 60;

// //   int _secondsRemaining = 0;
// //   Timer? _timer;

// //   final TextEditingController _otpController = TextEditingController();

// //   bool _isVerifying = false;

// //   bool get _canResend => _secondsRemaining == 0;
// //   bool get _isCountingDown => _secondsRemaining > 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   void _startResendTimer() {
// //     _secondsRemaining = _resendTimeout;
// //     _timer?.cancel();

// //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
// //       if (_secondsRemaining == 0) {
// //         timer.cancel();
// //       } else {
// //         setState(() {
// //           _secondsRemaining--;
// //         });
// //       }
// //     });
// //   }

// //   // @override
// //   // void dispose() {
// //   //   _timer?.cancel();
// //   //   _otpController.dispose();
// //   //   super.dispose();
// //   // }

// //   void _onResend() {
// //     if (!_canResend) return;

// //     setState(() {
// //       _otpController.clear();
// //     });

// //     // TODO: Call resend OTP API here
// //     _startResendTimer();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // 🔴 RED after resend, GREY normally
// //     final Color borderColor = _isCountingDown
// //         ? const Color(0xFFFF5A21)
// //         : const Color(0xFFECECEC);

// //     return Scaffold(
// //       backgroundColor: _isVerifying ? Colors.white : const Color(0xFFF5F5F5),

// //    appBar: AppBar(
// //   backgroundColor: _isVerifying ? Colors.white : const Color(0xFFF5F5F5),
// //   elevation: 0,
// //   automaticallyImplyLeading: false,
// //   leading: Padding(
// //     padding: const EdgeInsets.only(left: 8),
// //     child: GestureDetector(
// //       onTap: () {
// //         if (_isVerifying) {
// //           setState(() {
// //             _isVerifying = false; // go back to OTP screen
// //           });
// //         } else {
// //           Navigator.pop(context); // normal back
// //         }
// //       },
// //       child: Container(
// //         width: 44,
// //         height: 44,
// //         decoration: BoxDecoration(
// //           color: _isVerifying
// //               ? Colors.transparent
// //               : const Color(0xFFF2F2F2),
// //           shape: BoxShape.circle,
// //         ),
// //         alignment: Alignment.center,
// //         child: SvgPicture.asset(
// //           'assets/images/back_arrow.svg',
// //           width: 40,
// //           height: 40,
// //           fit: BoxFit.contain,
// //         ),
// //       ),
// //     ),
// //   ),
// // ),


// //       // ✅ SWITCH BETWEEN OTP & VERIFYING
// //       body: _isVerifying
// //           ? _buildVerifyingScreen()
// //           : Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text.rich(
// //                     TextSpan(
// //                       children: [
// //                         const TextSpan(
// //                           text: 'Verify your number\n\n',
// //                           style: TextStyle(
// //                             fontFamily: 'RedHatDisplay',
// //                             fontSize: 28,
// //                             fontWeight: FontWeight.bold,
// //                             height: 1.4,
// //                             color: Color(0xFF1C2A39),
// //                           ),
// //                         ),
// //                         const TextSpan(
// //                           text: 'Enter the 4-digit code we sent to\n',
// //                           style: TextStyle(
// //                             fontFamily: 'WorkSans',
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w400,
// //                             height: 1.5,
// //                             color: Color(0xFF6B6B6B),
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: widget.phoneNumber,
// //                           style: const TextStyle(
// //                             fontFamily: 'WorkSans bold',
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                             height: 1.5,
// //                             color: Color.fromARGB(255, 18, 18, 18),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   const SizedBox(height: 16),

// //                   // 🔢 OTP
// //                   PinCodeTextField(
// //                     appContext: context,
// //                     length: 4,
// //                     controller: _otpController,
// //                     keyboardType: TextInputType.number,
// //                     autoFocus: true,
// //                     animationType: AnimationType.fade,
// //                     inputFormatters: [
// //                       FilteringTextInputFormatter.digitsOnly,
// //                     ],
// //                     textStyle: const TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                     onChanged: (value) {},
// //                     pinTheme: PinTheme(
// //                       shape: PinCodeFieldShape.box,
// //                       borderRadius: BorderRadius.circular(9),
// //                       fieldHeight: 58,
// //                       fieldWidth: 60,
// //                       activeFillColor: Colors.white,
// //                       inactiveFillColor: Colors.white,
// //                       selectedFillColor: Colors.white,
// //                       inactiveColor: borderColor,
// //                       activeColor: borderColor,
// //                       selectedColor: borderColor,
// //                     ),
// //                     enableActiveFill: true,
// //                   ),

// //                   const SizedBox(height: 16),

// //                   Center(
// //                     child: TextButton(
// //                       onPressed: _canResend ? _onResend : null,
// //                       child: Text(
// //                         _canResend
// //                             ? 'Resend code'
// //                             : 'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
// //                         style: TextStyle(
// //                           fontFamily: 'WorkSans SemiBold',
// //                           color: _canResend
// //                               ? const Color(0xFF1C2A39)
// //                               : const Color(0xFFFF5A21),
// //                           fontWeight: FontWeight.w700,
// //                         ),
// //                       ),
// //                     ),
// //                   ),

// //                   const Spacer(),

// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 52,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFFFF5A21),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(26),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         setState(() {
// //                           _isVerifying = true;
// //                         });

// //                         // TODO: Call verify API here
// //                       },
// //                       child: const Text(
// //                         'verify phone number',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w700,
// //                           height: 1.2,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //     );
// //   }

// //   // ✅ VERIFYING — FULL WHITE, NO EXTRA BACK ARROW
// //   Widget _buildVerifyingScreen() {
// //     return Center(
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: const [
// //           CircularProgressIndicator(color: Color(0xFFFF5A21)),
// //           SizedBox(height: 12),

// //           Text(
// //             'Verifying',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontFamily: 'WorkSans SemiBold',
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //               height: 1.3,
// //               color: Color(0xFF1C2A39),
// //             ),
// //           ),

// //           SizedBox(height: 6),

// //           Text(
// //             'It only takes few seconds to verify',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontFamily: 'WorkSans',
// //               fontSize: 13,
// //               fontWeight: FontWeight.w400,
// //               height: 1.5, // 150%
// //               color: Color(0xFF6B6B6B),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
