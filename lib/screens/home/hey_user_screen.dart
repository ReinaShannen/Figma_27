import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_state.dart';

class HeyUserScreen extends StatelessWidget {
  const HeyUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = AppState.displayName.trim();
    final greetingName = name.isEmpty ? 'there' : name;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;
            final cardHeight = 537.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(
                    height: cardHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/groups.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xB3000000),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/ami_logo.svg',
                                width: 158,
                                height: 44,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'No groups yet',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Create a group to start saving together and unlock shared experiences later.',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/create-group-intro',
                                  );
                                },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFFFF5A1F),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 10,
                                      ),
                                    ),
                                    child: const Text(
                                      'Create group',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
    final color = isActive ? const Color(0xFF1C2A39) : const Color(0xFF9E9E9E);
    return SvgPicture.asset(
      assetPath,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
