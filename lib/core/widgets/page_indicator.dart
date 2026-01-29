import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24, // h24
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalCount,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 24,
            height: 4,
            decoration: BoxDecoration(
              color: index == currentIndex
                  ? const Color(0xFFFFFFFF) // active
                  : const Color(0xFF7A7A7A), // inactive
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}