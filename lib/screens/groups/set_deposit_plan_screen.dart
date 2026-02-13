import 'package:flutter/material.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/app_texfield.dart';
import '../../core/widgets/step_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../groups/widgets/confirm_group_sheet.dart';

class SetDepositPlanScreen extends StatefulWidget {
  const SetDepositPlanScreen({super.key});

  @override
  State<SetDepositPlanScreen> createState() => _SetDepositPlanScreenState();
}

class _SetDepositPlanScreenState extends State<SetDepositPlanScreen> {
  final TextEditingController amountController = TextEditingController(
    text: "173.00",
  );

  int selectedFrequency = 0;
  int selectedDay = 0;
  int selectedDate = 19;

  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  CommonBackButton(),
                  SizedBox(width: 16),
                  Expanded(child: StepProgressBar(currentStep: 2)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 TITLE
                    const Text(
                      "Set your deposit plan",
                      style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Choose how much and how often everyone saves.",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// 🔹 AMOUNT
                    const Text(
                      "Deposit amount (£)",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "The amount each person will contribute into the group pot every time deposits are made.",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    AppTextField(
                      controller: amountController,
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 32),

                    /// 🔹 FREQUENCY
                    const Text(
                      "Frequency",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "How often everyone’s deposit will be collected.",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _toggleButton("Weekly", 0),
                        const SizedBox(width: 8),
                        _toggleButton("Monthly", 1),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// 🔹 WEEKLY
                    if (selectedFrequency == 0) ...[
                      const Text(
                        "Deposit day",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C2A39),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "How often everyone’s deposit will be collected.",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF6B6B6B),
                        ),
                      ),

                      const SizedBox(height: 12),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: days.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1.1,
                            ),
                        itemBuilder: (context, index) {
                          final selected = selectedDay == index;

                          return GestureDetector(
                            onTap: () => setState(() => selectedDay = index),
                            child: Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF1C2A39)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                ),
                              ),
                              child: Text(
                                days[index],
                                style: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFF364153),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ]
                    /// 🔹 MONTHLY
                    else ...[
                      const Text(
                        "Deposit date",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C2A39),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Choose when the deposit happens (e.g. on the 1st of each month).",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF6B6B6B),
                        ),
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2024, 1, selectedDate),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2030),
                          );

                          if (picked != null) {
                            setState(() => selectedDate = picked.day);
                          }
                        },
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/calendar.svg",
                                width: 18,
                                height: 18,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF6B6B6B),
                                  BlendMode.srcIn,
                                ),
                              ),

                              const SizedBox(width: 10),
                              Text(
                                "$selectedDate of every month",
                                style: const TextStyle(
                                  fontFamily: "WorkSans",
                                  fontSize: 14,
                                  color: Color(0xFF364153),
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 59),
                  ],
                ),
              ),
            ),

            /// 🔹 NEXT BUTTON
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => ConfirmGroupSheet(
                          amount: amountController.text,
                          frequency: selectedFrequency == 0
                              ? "Weekly"
                              : "Monthly",
                          depositValue: selectedFrequency == 0
                              ? days[selectedDay]
                              : "$selectedDate of every month",
                          onConfirm: () {
                            Navigator.pop(context);
                            // TODO: go invite screen
                          },
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
                        color: Colors.white,
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

  Widget _toggleButton(String text, int index) {
    final selected = selectedFrequency == index;

    return GestureDetector(
      onTap: () => setState(() => selectedFrequency = index),
      child: Container(
        width: 88,
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1C2A39) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "WorkSans",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF364153),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../core/widgets/back_button.dart';
// import '../../core/widgets/app_texfield.dart';
// import '../../core/widgets/step_progress_bar.dart';

// class SetDepositPlanScreen extends StatefulWidget {
//   const SetDepositPlanScreen({super.key});

//   @override
//   State<SetDepositPlanScreen> createState() => _SetDepositPlanScreenState();
// }

// class _SetDepositPlanScreenState extends State<SetDepositPlanScreen> {
//   final TextEditingController amountController =
//       TextEditingController(text: "173.00");

//   int selectedFrequency = 0; // 0 weekly, 1 monthly
//   int selectedDay = 0;
//   int selectedDate = 19;

//   final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 8),

//             /// TOP BAR
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: const [
//                   CommonBackButton(),
//                   SizedBox(width: 16),
//                   Expanded(child: StepProgressBar(currentStep: 2)),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),

//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// TITLE
//                     const Text(
//                       "Set your deposit plan",
//                       style: TextStyle(
//                         fontFamily: "RedHatDisplay",
//                         fontSize: 28,
//                         fontWeight: FontWeight.w700,
//                         height: 1.4,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     const Text(
//                       "Choose how much and how often everyone saves.",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 16,
//                         height: 1.5,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),

//                     const SizedBox(height: 32),

//                     /// AMOUNT
//                     const Text(
//                       "Deposit amount (£)",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         height: 1.3,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     const Text(
//                       "The amount each person will contribute into the group pot every time deposits are made.",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         height: 1.5,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     AppTextField(
//                       controller: amountController,
//                       hint: "",
//                       keyboardType: TextInputType.number,
//                     ),

//                     const SizedBox(height: 32),

//                     /// FREQUENCY
//                     const Text(
//                       "Frequency",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     const Text(
//                       "How often everyone’s deposit will be collected.",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 13,
//                         height: 1.5,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),

//                     const SizedBox(height: 6),

//                     Row(
//                       children: [
//                         _toggleButton("Weekly", 0),
//                         const SizedBox(width: 8),
//                         _toggleButton("Monthly", 1),
//                       ],
//                     ),

//                     const SizedBox(height: 28),

//                     /// CONDITIONAL UI
//                     if (selectedFrequency == 0) ...[
//                       /// WEEKLY
//                       const Text(
//                         "Deposit day",
//                         style: TextStyle(
//                           fontFamily: "WorkSans",
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF1C2A39),
//                         ),
//                       ),

//                    const SizedBox(height: 6),

//                     const Text(
//                       "How often everyone’s deposit will be collected.",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 13,
//                         height: 1.5,
//                         color: Color(0xFF6B6B6B),
//                       ),
//                     ),

// Padding(
//   padding: const EdgeInsets.only(top: 12),
//   child: GridView.builder(

//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: days.length,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 5,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 52 / 56,

//                       ),
//                       itemBuilder: (context, index) {
//                         final selected = selectedDay == index;

//                         return GestureDetector(
//                           onTap: () => setState(() => selectedDay = index),
//                           child: Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: selected
//                                   ? const Color(0xFF1C2A39)
//                                   : Colors.white,
//                               borderRadius: BorderRadius.circular(9),
//                               border: Border.all(color: const Color(0xFFE5E7EB)),
//                             ),
//                             child: Text(
//                               days[index],
//                               style: TextStyle(
//                                 fontFamily: "WorkSans",
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: selected
//                                     ? Colors.white
//                                     : const Color(0xFF364153),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
// )

//                     ] else ...[
//                       /// MONTHLY
//                       const Text(
//                         "Deposit date",
//                         style: TextStyle(
//                           fontFamily: "WorkSans",
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF1C2A39),
//                         ),
//                       ),

//                       const SizedBox(height: 6),

//                       const Text(
//                         "Choose when the deposit happens (e.g. on the 1st of each month).",
//                         style: TextStyle(
//                           fontFamily: "WorkSans",
//                           fontSize: 13,
//                           height: 1.5,
//                           color: Color(0xFF6B6B6B),
//                         ),
//                       ),

//                       GestureDetector(
//                         onTap: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime(2024, 1, selectedDate),
//                             firstDate: DateTime(2024),
//                             lastDate: DateTime(2030),
//                           );

//                           if (picked != null) {
//                             setState(() => selectedDate = picked.day);
//                           }
//                         },
//                         child: Container(
//                           height: 52,
//                           padding: const EdgeInsets.symmetric(horizontal: 14),
//                           alignment: Alignment.centerLeft,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                                 color: const Color(0xFFE5E7EB)),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.calendar_today,
//                                   size: 18, color: Color(0xFF6B6B6B)),
//                               const SizedBox(width: 10),
//                               Text(
//                                 "$selectedDate of every month",
//                                 style: const TextStyle(
//                                   fontFamily: "WorkSans",
//                                   fontSize: 14,
//                                   color: Color(0xFF364153),
//                                 ),
//                               ),
//                               const Spacer(),
//                               const Icon(Icons.keyboard_arrow_down),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                     const SizedBox(height: 59),

//                   ],
//                 ),
//               ),
//             ),

//             /// NEXT BUTTON
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),

//                 child: SizedBox(
//                   height: 54,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF5A1F),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     ),
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _toggleButton(String text, int index) {
//     final selected = selectedFrequency == index;

//     return GestureDetector(
//       onTap: () => setState(() => selectedFrequency = index),
//       child:Container(
//   width: 88,
//   height: 56,
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     color: selected ? const Color(0xFF1C2A39) : Colors.white,
//     borderRadius: BorderRadius.circular(12),
//     border: Border.all(color: const Color(0xFFE5E7EB)),
//   ),

//         child: Text(
//           text,
//           style: TextStyle(
//             fontFamily: "WorkSans",
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: selected ? Colors.white : const Color(0xFF364153),
//           ),
//         ),
//       ),
//     );
//   }
// }
