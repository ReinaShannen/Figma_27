import 'package:flutter/material.dart';
import '../home/groups_experiences.dart';
class GroupCreatedScreen extends StatelessWidget {
  const GroupCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            /// 🎉 Illustration
            Image.asset(
              "assets/images/celebration.png",
              width: 216,
              height: 252,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 45),

            /// Title
            const Text(
              "Group created\nsuccessfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontWeight: FontWeight.w700,
                fontSize: 32,
                height: 1.35,
                color: Color(0xFF1C2A39),
              ),
            ),

            const SizedBox(height: 16),

            /// Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Invite your friends to join by sharing your group link.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "WorkSans",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF1C2A39),
                ),
              ),
            ),

            const Spacer(),

            /// Continue to home
TextButton(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const GroupExperiences(),
      ),
    );
  },
  child: const Text(
    "Continue to Home",
    style: TextStyle(
      fontFamily: "WorkSans",
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.2,
      color: Color(0xFF1C2A39),
    ),
  ),
),


            const SizedBox(height: 34.5), // exact spacing

            /// Button section
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, // left
                0,
                16, // right
                24, // bottom
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.link_rounded, size: 20),
                  label: const Text(
                    "Invite members",
                    style: TextStyle(
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A1F),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
