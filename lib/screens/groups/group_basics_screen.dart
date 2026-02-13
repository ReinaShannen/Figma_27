import 'package:flutter/material.dart';
import '../../core/widgets/app_texfield.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/step_progress_bar.dart';
import '../groups/set_deposit_plan_screen.dart';

class GroupBasicsScreen extends StatefulWidget {
  const GroupBasicsScreen({super.key});

  @override
  State<GroupBasicsScreen> createState() => _GroupBasicsScreenState();
}

class _GroupBasicsScreenState extends State<GroupBasicsScreen> {
  final TextEditingController nameController = TextEditingController();
  int selectedColorIndex = 1;

  final List<Map<String, dynamic>> colors = [
    {"name": "Sunflower", "color": const Color(0xFFF4C430)},
    {"name": "Ocean", "color": const Color(0xFF00AEEF)},
    {"name": "Sunset", "color": const Color(0xFFFF6B6B)},
    {"name": "Forest", "color": const Color(0xFF34C759)},
    {"name": "Lavender", "color": const Color(0xFF9B59B6)},
    {"name": "Coral", "color": const Color(0xFFFF7675)},
    {"name": "Mint", "color": const Color(0xFF1ABC9C)},
    {"name": "Amber", "color": const Color(0xFFFFA726)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            /// 🔹 TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const CommonBackButton(),
                  const SizedBox(width: 16),

                  const Expanded(child: StepProgressBar(currentStep: 1)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 SCROLL AREA
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    const Text(
                      "Let’s start with the basics",
                      style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Name your group and choose an image to represent your group.",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// IMAGE
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 42,
                            backgroundColor: Color(0xFFEAEAEA),
                            backgroundImage: AssetImage(
                              "assets/images/groups.png",
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// TEXT FIELD
                    const AppTextField(
                      hint: "", // removed hint text
                    ),

                    const SizedBox(height: 40.5),

                    const Text(
                      "Group color",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 6),
                    const Text(
                      "This color will help you identify your group throughout the app",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// GRID
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: colors.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.82,
                          ),
                      itemBuilder: (context, index) {
                        final item = colors[index];
                        final selected = index == selectedColorIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(14),
                              border: selected
                                  ? Border.all(
                                      color: const Color(0xFF00AEEF),
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: item["color"],
                                    shape: BoxShape.circle,
                                  ),
                                  child: selected
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : null,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontFamily: "WorkSans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.33, // ≈16px
                                    color: Color(0xFF364153),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 BUTTON
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SetDepositPlanScreen(),
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
                      "Next",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 248, 248, 248),
                      ),
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
