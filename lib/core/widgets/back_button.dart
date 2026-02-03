import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CommonBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
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
    );
  }
}
