import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep; // 1..totalSteps
  final int totalSteps; // default matches Figma flow

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
  }) : assert(currentStep >= 1),
       assert(totalSteps >= 1),
       assert(currentStep <= totalSteps);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final step = index + 1;

        Color color;

        if (step < currentStep) {
          color = const Color(0xFFFFCABA); // completed = faint orange
        } else if (step == currentStep) {
          color = const Color(0xFFFF5A1F); // active = strong orange
        } else {
          color = const Color(0xFFE5E7EB); // future = grey
        }

        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
