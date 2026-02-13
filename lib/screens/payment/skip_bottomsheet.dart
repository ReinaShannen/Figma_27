import 'package:flutter/material.dart';

class SkipAddCardBottomSheet extends StatelessWidget {
  const SkipAddCardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const Text(
              'Skip adding card?',
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                fontSize: 28,
                height: 1.4,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C2A39),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Without a payment card, you can explore Ami, but you won’t be able to create or join any groups until one is added. You can always add it later in your profile settings.',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B6B6B),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // Secondary button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Skip for now
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  side: const BorderSide(color: Color(0xFFECECEC)),
                ),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C2A39),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Primary button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5A1F),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Add card now',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
