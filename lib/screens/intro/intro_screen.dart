

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/primary_button.dart';
import '../signup/signup_screen.dart';
import 'intro_view_model.dart';


class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final IntroViewModel _viewModel = IntroViewModel();
  
  

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
   


    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;

            return isLandscape
                ? _buildLandscapeLayout(context)
                : _buildPortraitLayout(context, bottomInset);
          },
        ),
      ),
    );
  }

//portrait 
 Widget _buildPortraitLayout(BuildContext context, double bottomInset) {
  return Column(
    children: [
    
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/ami_logo.svg',
                width: 80,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Image.asset(
                  'assets/images/group_5.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Save together &\nExperience more',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Color(0xFF1C2A39),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Ami makes group saving simple,\nsocial, and effortless',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF6B6B6B),
                ),
              ),
            ],
          ),
        ),
      ),

      // BUTTON
      Padding(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 16 + bottomInset),
        child: Column(
          children: [
            PrimaryButton(
              text: 'Login',
              color: AppColors.dark,
              onTap: () {},
            ),
            const SizedBox(height: 12),
PrimaryButton(
  text: 'Create an account',
  color: AppColors.primary,
  onTap: () => _viewModel.onCreateAccount(context),
),

          ],
        ),
      ),
    ],
  );
}


  // landscape
  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
       
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),

                SvgPicture.asset(
                  'assets/images/ami_logo.svg',
                  width: 90,
                ),

                const SizedBox(height: 24),

                Image.asset(
                  'assets/images/group_5.png',
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 32),

                const Text(
                  'Save together &\nExperience more',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: Color(0xFF1C2A39),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Ami makes group saving simple,\nsocial, and effortless',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF6B6B6B),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
PrimaryButton(
  text: 'Login',
  color: AppColors.dark,
  onTap: () => _viewModel.onLogin(context),
),

                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Create an account',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//Portrait orientation focused implementation

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../constants/colors.dart';
// import '../widgets/primary_button.dart';
// import 'signup_screen.dart';

// class IntroScreen extends StatelessWidget {
//   const IntroScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).padding.bottom;

//     return Scaffold(
//       backgroundColor: Colors.deepOrange.shade50,
//       body: SafeArea(
//         child: Column(
//           children: [

//             Flexible(
//               fit: FlexFit.loose,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 12),

//                     SvgPicture.asset(
//                       'assets/images/ami_logo.svg',
//                       width: 90,
//                     ),

//                     const SizedBox(height: 20),

//                     Flexible(
//                       fit: FlexFit.loose,
//                       child: Image.asset(
//                         'assets/images/group_5.png',
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     const Text(
//                       'Save together &\nExperience more',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'RedHatDisplay',
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         height: 1.4,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     const Text(
//                       'Ami makes group saving simple,\nsocial, and effortless',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'WorkSans',
//                         fontSize: 16,
//                         height: 1.5,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

                  
//                   ],
//                 ),
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.fromLTRB(
//                 24,
//                 16,
//                 24,
//                 16 + bottomInset,
//               ),
//               child: Column(
//                 children: [
//                   /// LOGIN (no navigation for now)
//                   PrimaryButton(
//                     text: 'Login',
//                     color: AppColors.dark,
//                     onTap: () {
//                       // intentionally left empty
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                 //sign up button
//                   PrimaryButton(
//                     text: 'Create an account',
//                     color: AppColors.primary,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => SignupScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

