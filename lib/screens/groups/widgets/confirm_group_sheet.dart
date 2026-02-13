import 'package:flutter/material.dart';
import '../invite_members_screen.dart';

class ConfirmGroupSheet extends StatelessWidget {
  final String amount;
  final String frequency;
  final String depositValue;
  final VoidCallback onConfirm;

  const ConfirmGroupSheet({
    super.key,
    required this.amount,
    required this.frequency,
    required this.depositValue,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            const Text(
              "Confirm group details",
              style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.4,
                color: Color(0xFF1C2A39),
              ),
            ),

            /// spacing: title → subtitle = 16
            const SizedBox(height: 16),

            const Text(
              "Double check the information below:",
              style: TextStyle(
                fontFamily: "WorkSans",
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF67707A),
              ),
            ),

            /// spacing: subtitle → white box = 40
            const SizedBox(height: 40),

            /// WHITE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
              decoration: BoxDecoration(
                color: Colors.white, // ← FIXED
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pair("Deposit amount (£)", "£$amount"),
                  const SizedBox(height: 16),
                  _pair("Frequency", frequency),
                  const SizedBox(height: 16),
                  _pair(
                    frequency == "Weekly"
                        ? "Deposit day"
                        : "Deposit date",
                    depositValue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// BUTTONS
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5E7EB),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        "Not yet",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1C2A39),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
  Navigator.pop(context); // close bottom sheet first

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const InviteMembersScreen(),
    ),
  );
},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5A1F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        "Confirm details",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// label + value pair
  Widget _pair(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// label
        Text(
          label,
          style: const TextStyle(
            fontFamily: "WorkSans",
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF67707A),
          ),
        ),

        /// spacing label → value = 4
        const SizedBox(height: 4),

        /// value
        Text(
          value,
          style: const TextStyle(
            fontFamily: "WorkSans",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.5,
            color: Color(0xFF1C2A39),
          ),
        ),
      ],
    );
  }
}
