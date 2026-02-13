import 'package:flutter/material.dart';
import '../../core/widgets/back_button.dart';
import '../../screens/groups/create_group_intro_screen.dart';
import 'group_basics_screen.dart';


class CreateGroupIntroScreen extends StatelessWidget {
  const CreateGroupIntroScreen({super.key});

  static const double _horizontalPadding = 24;
  static const double _contentTopPadding = 8;
  static const double _contentBottomPadding = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1C2E),

      /// 🔻 BOTTOM BUTTON AREA
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding,
            _contentTopPadding,
            _horizontalPadding,
            _contentBottomPadding +
                MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// SKIP
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// LETS DO IT BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GroupBasicsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A1F),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Let’s do it',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// 🔻 BODY
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                _horizontalPadding,
                _contentTopPadding,
                _horizontalPadding,
                _contentBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonBackButton(),
                  const SizedBox(height: 16),

                  const Text(
                    'Ready to create your first\ngroup?',
                    style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'You can start now or come back to it later, it only takes a few minutes.',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 16,
                      height: 1.5,
                      color: Color(0xFFB9C1CC),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const _StepItem(
                    number: '1',
                    title: 'Add group details',
                    subtitle: 'Name your group and give it an image',
                  ),
                  const _StepItem(
                    number: '2',
                    title: 'Set your deposit plan',
                    subtitle: 'Choose how much to save.',
                  ),
                  const _StepItem(
                    number: '3',
                    title: 'Invite your members',
                    subtitle: 'Share a link to add members',
                  ),
                  const _StepItem(
                    number: '4',
                    title: 'Verify your account',
                    subtitle: 'Quick check to keep funds secure.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔻 STEP ITEM WIDGET
class _StepItem extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _StepItem({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5A1F),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFFB9C1CC),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
