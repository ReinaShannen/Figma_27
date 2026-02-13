import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/widgets/back_button.dart';
import '../../core/widgets/step_progress_bar.dart';

class VerifyIdentityScreen extends StatelessWidget {
  const VerifyIdentityScreen({super.key});

  // 🔹 lighter background
  static const _screenBg = Color(0xFFF4F5F6);

  // 🔹 shared secondary text color
  static const _secondaryText = Color(0xFF8A8A8A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,

      /// 🔻 bottom section
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// helper text (2 lines exactly like Figma)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'This process is quick, secure, and\nonly needs to be done once.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: _secondaryText,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// button
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A1F),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Start verification',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.open_in_new, size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// 🔻 body
      body: SafeArea(
        bottom: false,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// top row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    CommonBackButton(),
                    SizedBox(width: 16),
                    Expanded(child: StepProgressBar(currentStep: 4)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _GriffinHeader(),
                    SizedBox(height: 24),

                    /// title
                    Text(
                      'Verify your identity',
                      style: TextStyle(
                        fontFamily: 'RedHatDisplay',
                        fontSize: 28,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    SizedBox(height: 16),

                    /// description
                    Text(
                      'To keep your group’s money secure, we need\n'
                      'to confirm your identity with our banking partner\n'
                      'before you can start saving and\n'
                      'spending together.',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: _secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GriffinHeader extends StatelessWidget {
  const _GriffinHeader();

  static const _assetPath = 'assets/images/GriffinPng.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188,
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      alignment: Alignment.centerLeft,
      child: Image.asset(
        _assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Griffin',
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    fontSize: 28,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C2A39),
                  ),
                ),
                TextSpan(text: ' '),
                TextSpan(text: '🔥'),
              ],
            ),
          );
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../core/widgets/back_button.dart';
// import '../../core/widgets/step_progress_bar.dart';

// class VerifyIdentityScreen extends StatelessWidget {
//   const VerifyIdentityScreen({super.key});

//   static const _screenBg = Color(0xFFE8EAEB);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _screenBg,
//       bottomNavigationBar: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Text(
//                   'This process is quick, secure,and only needs to\n be done once.',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontFamily: 'WorkSans',
//                     fontSize: 16,
//                     height: 1.5,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xFF6B6B6B),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 56,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFF5A1F),
//                     elevation: 0,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(28),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Text(
//                         'Start verification',
//                         style: TextStyle(
//                           fontFamily: 'WorkSans',
//                           fontSize: 16,
//                           height: 1.2,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Icon(Icons.open_in_new, size: 18, color: Colors.white),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         bottom: false,
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle.dark,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: const [
//                     CommonBackButton(),
//                     SizedBox(width: 16),
//                     Expanded(child: StepProgressBar(currentStep: 4)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     _GriffinHeader(),
//                     SizedBox(height: 24),
//                     Text(
//                       'Verify your identity',
//                       style: TextStyle(
//                         fontFamily: 'RedHatDisplay',
//                         fontSize: 28,
//                         height: 1.4,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       'To keep your group’s money secure, we need\n'
//                       'to confirm your identity with our banking partner\n'
//                       'before you can start saving and \nspending together.',
//                       style: TextStyle(
//                         fontFamily: 'WorkSans',
//                         fontSize: 14,
//                         height: 1.5,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _GriffinHeader extends StatelessWidget {
//   const _GriffinHeader();

//   static const _assetPath = 'assets/images/GriffinPng.png';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 188,
//       height: 73,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(9),
//         border: Border.all(color: const Color(0xFFECECEC)),
//       ),
//       alignment: Alignment.centerLeft,
//       child: Image.asset(
//         _assetPath,
//         fit: BoxFit.contain,
//         errorBuilder: (context, error, stackTrace) {
//           return const Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Griffin',
//                   style: TextStyle(
//                     fontFamily: 'RedHatDisplay',
//                     fontSize: 28,
//                     height: 1.1,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1C2A39),
//                   ),
//                 ),
//                 TextSpan(text: ' '),
//                 TextSpan(text: '🔥'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
