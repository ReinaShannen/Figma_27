import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_state.dart';

class GroupExperiences extends StatelessWidget {
  const GroupExperiences({super.key});

  @override
  Widget build(BuildContext context) {
    final name = AppState.displayName.trim();
    final greetingName = name.isEmpty ? 'there' : name;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1C2A39),
        unselectedItemColor: const Color(0xFF9E9E9E),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: _NavIcon('assets/images/home.svg', isActive: true),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon('assets/images/ppl.svg'),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon('assets/images/chat.svg'),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon('assets/images/experience.svg'),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: _NavIcon('assets/images/profile.svg'),
            label: 'Profile',
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Hey $greetingName!',
                      style: const TextStyle(
                        fontFamily: 'RedHatDisplay',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        color: Color(0xFF1C2A39),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/not.svg',
                    width: 36,
                    height: 36,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// GROUP TITLE
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Groups',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: Color(0xFF1C2A39),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/plus button.svg',
                    width: 28,
                    height: 28,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// GROUP CARD - Just the image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/trip2.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              /// EXPERIENCES TITLE
              const Text(
                'Experiences',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: Color(0xFF1C2A39),
                ),
              ),

              const SizedBox(height: 12),

              /// EXPERIENCE CARD WITH OVERLAPPING BOTTOM CARD
              Stack(
                clipBehavior: Clip.none,
                children: [
                  /// BACKGROUND IMAGE - NO rounded corners
                  Image.asset(
                    'assets/images/trip1.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  /// OVERLAPPING WHITE CARD - Positioned lower with proper shadow
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: -90,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 24,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Create your first shared experience',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              color: Color(0xFF1C2A39),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create an experience to enable spending from your group funds.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Color(0xFF6B6B6B),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF5A1F),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: const Text(
                                'Create Experience',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// Extra spacing to account for overlapping card positioned lower
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final String assetPath;
  final bool isActive;

  const _NavIcon(this.assetPath, {this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? const Color(0xFF1C2A39) : const Color(0xFF9E9E9E);

    return SvgPicture.asset(
      assetPath,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}