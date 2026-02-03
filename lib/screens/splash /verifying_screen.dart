import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/password /create_password_screen.dart';

class VerifyingScreen extends StatefulWidget {
  const VerifyingScreen({super.key});

  @override
  State<VerifyingScreen> createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {
  bool _isVerified = false;
  Timer? _timer;

  @override
  // void initState() {
  //   super.initState();

  //   // ⏱ Simulate verification delay
  //   _timer = Timer(const Duration(seconds:5), () {
  //     if (mounted) {
  //       setState(() {
  //         _isVerified = true;
  //       });
  //     }
  //   });
  // }
  @override
void initState() {
  super.initState();

  _timer = Timer(const Duration(seconds: 5), () {
    if (!mounted) return;

    setState(() {
      _isVerified = true;
    });

    // ⏱ show "Verified" for a moment, then navigate
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const CreatePasswordScreen(),
        ),
      );
    });
  });
}


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
        ),
      ),

      body: SizedBox.expand(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _isVerified
              ? _buildSuccessState()
              : _buildLoadingState(),
        ),
      ),
    );
  }

  // ======================
  // LOADING STATE
  // ======================
  List<Widget> _buildLoadingState() {
    return const [
      CircularProgressIndicator(color: Color(0xFFFF5A21)),
      SizedBox(height: 12),
      Text(
        'Verifying',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'WorkSans SemiBold',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Color(0xFF1C2A39),
        ),
      ),
      SizedBox(height: 6),
      Text(
        'It only takes few seconds to verify...',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Color(0xFF6B6B6B),
        ),
      ),
    ];
  }

  // ======================
  // SUCCESS STATE
  // ======================
  List<Widget> _buildSuccessState() {
    return [
      Image.asset(
        'assets/images/Tick.png',
        width: 64,
        height: 64,
      ),

      const SizedBox(height: 12),
      const Text(
        'Verified',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'WorkSans SemiBold',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Color(0xFF1C2A39),
        ),
      ),
      const SizedBox(height: 6)

    ];
  }
}









// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class VerifyingScreen extends StatelessWidget {
//   const VerifyingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false, // 

  
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
// body: SizedBox.expand(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center, 
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: const [

//             CircularProgressIndicator(color: Color(0xFFFF5A21)),
//             SizedBox(height: 12),
//             Text(
//               'Verifying',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'WorkSans SemiBold',
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 height: 1.3,
//                 color: Color(0xFF1C2A39),
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'It only takes few seconds to verify...',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'WorkSans',
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 height: 1.5,
//                 color: Color(0xFF6B6B6B),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
