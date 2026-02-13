//skip for now issue--

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/step_progress_bar.dart';
import '../../core/widgets/country_picker.dart';
import '../groups/invite_contacts_sheet.dart';
import '../verification/verify_identity_screen.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  int selectedCountryIndex = 0;
  String selectedCountryCode = '+44';
  String selectedFlagAsset = 'assets/images/UK.svg';

  final List<Map<String, String>> countries = List.filled(6, {
    'name': 'United Kingdom',
    'code': '+44',
    'asset': 'assets/images/UK.svg',
  });

  List<Map<String, String>> contacts = [
    {"name": "Amazon", "phone": "+44 999 999 999"},
    {"name": "Joseph", "phone": "+44 999 999 999"},
    {"name": "Abdul Rahman", "phone": "+44 999 999 999"},
    {"name": "Aashish", "phone": "+44 999 999 999"},
    {"name": "Abi", "phone": "+44 999 999 999"},
    {"name": "Jebin", "phone": "+44 999 999 999"},
  ];

  List<int> selectedContacts = [];

  final TextEditingController phoneController = TextEditingController();

  void _openCountryPicker() {
    showCustomCountryPicker(
      context: context,
      countries: countries,
      selectedIndex: selectedCountryIndex,
      onSelect: (index, code, flagAsset) {
        setState(() {
          selectedCountryIndex = index;
          selectedCountryCode = code;
          selectedFlagAsset = flagAsset;
        });
      },
    );
  }

  void openInviteSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InviteContactsSheet(
        contacts: contacts,
        initiallySelected: selectedContacts,
        onDone: (list) {
          setState(() {
            selectedContacts = list;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            /// TOP NAV
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  CommonBackButton(),
                  SizedBox(width: 16),
                  Expanded(child: StepProgressBar(currentStep: 3)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Invite your members",
                      style: TextStyle(
                        fontFamily: "RedHatDisplay",
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Share invites to add members. They'll need to approve your savings plan.",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        color: Color(0xFF67707A),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// PHONE ROW
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _openCountryPicker,
                          child: Container(
                            width: 122,
                            height: 58,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  selectedFlagAsset,
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  selectedCountryCode,
                                  style: const TextStyle(
                                    fontFamily: "WorkSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.keyboard_arrow_down, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 58,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter number",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// SEND INVITE BUTTON
                    Container(
                      width: double.infinity,
                      height: 54,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5A1F),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Text(
                        "Send invite",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    GestureDetector(
                      onTap: openInviteSheet,
                      child: const Center(
                        child: Text(
                          "Invite from your contacts",
                          style: TextStyle(
                            fontFamily: "WorkSans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1C2A39),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// INVITE COUNT
                    Text(
                      "Invite (${selectedContacts.length})",
                      style: const TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1C2A39),
                      ),
                    ),

                    if (selectedContacts.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Column(
                        children: selectedContacts.map((i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF22C55E),
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    contacts[i]["phone"]!,
                                    style: const TextStyle(
                                      fontFamily: "WorkSans",
                                      fontSize: 16,
                                      color: Color(0xFF1C2A39),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF22C55E),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// 🔥 FIXED FOOTER (skip never disappears)
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: keyboardInset),
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Skip for now",
                        style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1C2A39),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VerifyIdentityScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// SKIP FOR NOW BUTTON CORRECT AFTER SELECTION BUT WITHOUT SELECTON FLOATS MIDWAY

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../core/widgets/back_button.dart';
// import '../../core/widgets/step_progress_bar.dart';
// import '../../core/widgets/country_picker.dart';
// import '../groups/invite_contacts_sheet.dart';

// class InviteMembersScreen extends StatefulWidget {
//   const InviteMembersScreen({super.key});

//   @override
//   State<InviteMembersScreen> createState() => _InviteMembersScreenState();
// }

// class _InviteMembersScreenState extends State<InviteMembersScreen> {
//   int selectedCountryIndex = 0;
//   String selectedCountryCode = '+44';
//   String selectedFlagAsset = 'assets/images/UK.svg';

//   final List<Map<String, String>> countries = List.filled(6, {
//     'name': 'United Kingdom',
//     'code': '+44',
//     'asset': 'assets/images/UK.svg',
//   });

//   List<Map<String, String>> contacts = [
//     {"name": "Amazon", "phone": "+44 999 999 999"},
//     {"name": "Joseph", "phone": "+44 999 999 999"},
//     {"name": "Abdul Rahman", "phone": "+44 999 999 999"},
//     {"name": "Aashish", "phone": "+44 999 999 999"},
//     {"name": "Abi", "phone": "+44 999 999 999"},
//     {"name": "Jebin", "phone": "+44 999 999 999"},
//   ];

//   List<int> selectedContacts = [];
//   final TextEditingController phoneController = TextEditingController();

//   void _openCountryPicker() {
//     showCustomCountryPicker(
//       context: context,
//       countries: countries,
//       selectedIndex: selectedCountryIndex,
//       onSelect: (index, code, flagAsset) {
//         setState(() {
//           selectedCountryIndex = index;
//           selectedCountryCode = code;
//           selectedFlagAsset = flagAsset;
//         });
//       },
//     );
//   }

//   void openInviteSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) => InviteContactsSheet(
//         contacts: contacts,
//         initiallySelected: selectedContacts,
//         onDone: (list) {
//           setState(() => selectedContacts = list);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),

//       body: SafeArea(
//         child: Stack(
//           children: [

//             /// 🔵 MAIN SCROLL CONTENT (UNCHANGED UI)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 140), // space for footer
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [

//                     /// TOP NAV
//                     Row(
//                       children: const [
//                         CommonBackButton(),
//                         SizedBox(width: 16),
//                         Expanded(child: StepProgressBar(currentStep: 3)),
//                       ],
//                     ),

//                     const SizedBox(height: 16),

//                     /// TITLE
//                     const Text(
//                       "Invite your members",
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
//                       "Share invites to add members. They'll need to approve your savings plan.",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 16,
//                         height: 1.5,
//                         color: Color(0xFF67707A),
//                       ),
//                     ),

//                     const SizedBox(height: 40),

//                     const Text(
//                       "Phone Number",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// PHONE ROW (UNCHANGED)
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: _openCountryPicker,
//                           child: Container(
//                             width: 122,
//                             height: 58,
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: const Color(0xFFE5E7EB)),
//                             ),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(selectedFlagAsset, width: 24),
//                                 const SizedBox(width: 6),
//                                 Text(selectedCountryCode),
//                                 const Spacer(),
//                                 const Icon(Icons.keyboard_arrow_down, size: 20),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 8),

//                         Container(
//                           width: 228,
//                           height: 58,
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: const Color(0xFFE5E7EB)),
//                           ),
//                           child: TextField(
//                             controller: phoneController,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Enter number",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 32),

//                     /// SEND INVITE BUTTON
//                     Container(
//                       width: double.infinity,
//                       height: 54,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFF5A1F),
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     child: const Text(
//                       "Send invite",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,   // ← THIS
//                       ),
//                     ),

//                                         ),

//                     const SizedBox(height: 35.5),

//                     GestureDetector(
//                       onTap: openInviteSheet,
//                       child: const Center(
//   child: Text(
//     "Invite from your contacts",
//     style: TextStyle(
//       fontFamily: "WorkSans",
//       fontSize: 16,
//       fontWeight: FontWeight.w600,
//       color: Color(0xFF1C2A39),
//     ),
//   ),
// ),

//                     ),

//                     const SizedBox(height: 32),

//                     /// INVITE COUNT
//                     Text(
//                       "Invite (${selectedContacts.length})",
//                       style: const TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// SELECTED CONTACTS
//                     Column(
//                       children: selectedContacts.map((i) {
//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 8),
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: const Color(0xFF22C55E)),
//                             color: Colors.white,
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(child: Text(contacts[i]["phone"]!)),
//                               const Icon(Icons.check_circle, color: Color(0xFF22C55E)),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// FIXED FOOTER (FIGMA MATCH)
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 color: const Color(0xFFF5F5F5),
//                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [

//                     const Text(
//                       "Skip for now",
//                       style: TextStyle(
//                         fontFamily: "WorkSans",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1C2A39),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     SizedBox(
//                       height: 56,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF5A1F),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(28),
//                           ),
//                         ),
//                         child: const Text(
//   "Next",
//   style: TextStyle(
//     fontFamily: "WorkSans",
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//     color: Colors.white,   // ← THIS
//   ),
// ),

//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import '../../core/widgets/back_button.dart';
// // import '../../core/widgets/step_progress_bar.dart';
// // import '../../core/widgets/country_picker.dart';
// // import '../groups/invite_contacts_sheet.dart';

// // class InviteMembersScreen extends StatefulWidget {
// //   const InviteMembersScreen({super.key});

// //   @override
// //   State<InviteMembersScreen> createState() => _InviteMembersScreenState();
// // }

// // class _InviteMembersScreenState extends State<InviteMembersScreen> {

// //   /// 🔹 SAME AS SIGNUP SCREEN
// //   int selectedCountryIndex = 0;
// //   String selectedCountryCode = '+44';
// //   String selectedFlagAsset = 'assets/images/UK.svg';

// //   final List<Map<String, String>> countries = List.filled(6, {
// //     'name': 'United Kingdom',
// //     'code': '+44',
// //     'asset': 'assets/images/UK.svg',
// //   });
// // List<Map<String, String>> contacts = [
// //   {"name": "Amazon", "phone": "+44 999 999 999"},
// //   {"name": "Joseph", "phone": "+44 999 999 999"},
// //   {"name": "Abdul Rahman", "phone": "+44 999 999 999"},
// //   {"name": "Aashish", "phone": "+44 999 999 999"},
// //   {"name": "Abi", "phone": "+44 999 999 999"},
// //   {"name": "Jebin", "phone": "+44 999 999 999"},
// // ];

// // List<int> selectedContacts = [];

// //   final TextEditingController phoneController = TextEditingController();

// //   /// 🔹 SAME PICKER FUNCTION AS SIGNUP
// //   void _openCountryPicker() {
// //     showCustomCountryPicker(
// //       context: context,
// //       countries: countries,
// //       selectedIndex: selectedCountryIndex,
// //       onSelect: (index, code, flagAsset) {
// //         setState(() {
// //           selectedCountryIndex = index;
// //           selectedCountryCode = code;
// //           selectedFlagAsset = flagAsset;
// //         });
// //       },
// //     );
// //   }
// //   void openInviteSheet() {
// //   showModalBottomSheet(
// //     context: context,
// //     isScrollControlled: true,
// //     backgroundColor: Colors.transparent,
// //     builder: (_) => InviteContactsSheet(
// //       contacts: contacts,
// //       initiallySelected: selectedContacts,
// //       onDone: (list) {
// //         setState(() {
// //           selectedContacts = list;
// //         });
// //       },
// //     ),
// //   );
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F5F5),

// //       body: SafeArea(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [

// //             /// TOP NAV
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               child: Row(
// //                 children: const [
// //                   CommonBackButton(),
// //                   SizedBox(width: 16),
// //                   Expanded(child: StepProgressBar(currentStep: 3)),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 16),

// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [

// //                     /// TITLE
// //                     const Text(
// //                       "Invite your members",
// //                       style: TextStyle(
// //                         fontFamily: "RedHatDisplay",
// //                         fontSize: 28,
// //                         fontWeight: FontWeight.w700,
// //                         height: 1.4,
// //                         color: Color(0xFF1C2A39),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 16),

// //                     /// SUBTITLE
// //                     const Text(
// //                       "Share invites to add members. They'll need to approve your savings plan.",
// //                       style: TextStyle(
// //                         fontFamily: "WorkSans",
// //                         fontSize: 16,
// //                         height: 1.5,
// //                         color: Color(0xFF67707A),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 40),

// //                     /// PHONE LABEL
// //                     const Text(
// //                       "Phone Number",
// //                       style: TextStyle(
// //                         fontFamily: "WorkSans",
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w600,
// //                         height: 1.3,
// //                         color: Color(0xFF1C2A39),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 12),

// //                     /// PHONE ROW
// //                     Row(
// //                       children: [

// //                         /// COUNTRY PICKER (same as signup)
// //                         GestureDetector(
// //                           onTap: _openCountryPicker,
// //                           child: Container(
// //                             width: 122,
// //                             height: 58,
// //                             padding: const EdgeInsets.symmetric(horizontal: 12),
// //                             decoration: BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius: BorderRadius.circular(12),
// //                               border: Border.all(color: const Color(0xFFE5E7EB)),
// //                             ),
// //                             child: Row(
// //                               children: [
// //                                 SvgPicture.asset(
// //                                   selectedFlagAsset,
// //                                   width: 24,
// //                                   height: 24,
// //                                   fit: BoxFit.contain,
// //                                 ),
// //                                 const SizedBox(width: 6),
// //                                 Text(
// //                                   selectedCountryCode,
// //                                   style: const TextStyle(
// //                                     fontFamily: "WorkSans",
// //                                     fontSize: 14,
// //                                     fontWeight: FontWeight.w500,
// //                                     color: Color(0xFF1C2A39),
// //                                   ),
// //                                 ),
// //                                 const Spacer(),
// //                                 const Icon(
// //                                   Icons.keyboard_arrow_down,
// //                                   size: 20,
// //                                   color: Color(0xFF67707A),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),

// //                         const SizedBox(width: 8),

// //                         /// PHONE FIELD
// //                         Container(
// //                           width: 228,
// //                           height: 58,
// //                           padding: const EdgeInsets.symmetric(horizontal: 12),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(12),
// //                             border: Border.all(color: const Color(0xFFE5E7EB)),
// //                           ),
// //                           child: TextField(
// //                             controller: phoneController,
// //                             keyboardType: TextInputType.phone,
// //                             decoration: const InputDecoration(
// //                               border: InputBorder.none,
// //                               hintText: "Enter number",
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),

// //                     const SizedBox(height: 32),

// //                     /// SEND INVITE BUTTON
// //                     Container(
// //                       width: double.infinity,
// //                       height: 54,
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(
// //                         color: const Color(0xFFE5E7EB),
// //                         borderRadius: BorderRadius.circular(28),
// //                       ),
// //                       child: const Text(
// //                         "Send invite",
// //                         style: TextStyle(
// //                           fontFamily: "WorkSans",
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w600,
// //                           color: Color(0xFF1C2A39),
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 35.5),
// // GestureDetector(
// //   onTap: () {
// //     showModalBottomSheet(
// //       context: context,
// //       backgroundColor: Colors.transparent,
// //       isScrollControlled: true,
// //       builder: (_) => InviteContactsSheet(
// //         contacts: contacts,
// //         initiallySelected: selectedContacts,
// //         onDone: (list) {
// //           setState(() {
// //             selectedContacts = list;
// //           });
// //         },
// //       ),
// //     );
// //   },
// //   child: const Center(
// //     child: Text("Invite from your contacts"),
// //   ),
// // ),

// //                     const SizedBox(height: 82.5),

// // /// INVITE COUNT (dynamic)
// // Padding(
// //   padding: const EdgeInsets.only(left: 16),
// //   child: Text(
// //     "Invite (${selectedContacts.length})",
// //     style: const TextStyle(
// //       fontFamily: "WorkSans",
// //       fontSize: 18,
// //       fontWeight: FontWeight.w600,
// //       color: Color(0xFF1C2A39),
// //     ),
// //   ),
// // ),

// // /// GREEN SELECTED CONTACT BOXES
// // if (selectedContacts.isNotEmpty) ...[
// //   const SizedBox(height: 12),

// //   Padding(
// //     padding: const EdgeInsets.symmetric(horizontal: 16),
// //     child: Column(
// //       children: selectedContacts.map((i) {
// //         return Container(
// //           margin: const EdgeInsets.only(bottom: 8),
// //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: const Color(0xFF22C55E)),
// //             color: Colors.white,
// //           ),
// //           child: Row(
// //             children: [
// //               Expanded(
// //                 child: Text(
// //                   contacts[i]["phone"]!,
// //                   style: const TextStyle(
// //                     fontFamily: "WorkSans",
// //                     fontSize: 16,
// //                     color: Color(0xFF1C2A39),
// //                   ),
// //                 ),
// //               ),
// //               const Icon(
// //                 Icons.check_circle,
// //                 color: Color(0xFF22C55E),
// //               ),
// //             ],
// //           ),
// //         );
// //       }).toList(),
// //     ),
// //   ),
// // ],

// //                     const SizedBox(height: 80),

// //                     //const SizedBox(height: 16),
// //                   ],
// //                 ),
// //               ),
// //             ),

// // Column(
// //   mainAxisSize: MainAxisSize.min,
// //   children: [

// //     /// SKIP FOR NOW (fixed position)
// //     const SizedBox(height: 8),
// //     const Text(
// //       "Skip for now",
// //       style: TextStyle(
// //         fontFamily: "WorkSans",
// //         fontSize: 16,
// //         fontWeight: FontWeight.w600,
// //         color: Color(0xFF1C2A39),
// //       ),
// //     ),

// //     const SizedBox(height: 12),

// //     /// NEXT BUTTON
// //     Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
// //       child: SizedBox(
// //         height: 56,
// //         width: double.infinity,
// //         child: ElevatedButton(
// //           onPressed: () {},
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: const Color(0xFFFF5A1F),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(28),
// //             ),
// //           ),
// //           child: const Text(
// //             "Next",
// //             style: TextStyle(
// //               fontFamily: "WorkSans",
// //               fontSize: 16,
// //               fontWeight: FontWeight.w600,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ),
// //       ),
// //     ),
// //   ],
// // )

// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
