import 'package:flutter/material.dart';

class InviteContactsSheet extends StatefulWidget {
  final List<Map<String, String>> contacts;
  final List<int> initiallySelected;
  final Function(List<int>) onDone;

  const InviteContactsSheet({
    super.key,
    required this.contacts,
    required this.initiallySelected,
    required this.onDone,
  });

  @override
  State<InviteContactsSheet> createState() => _InviteContactsSheetState();
}

class _InviteContactsSheetState extends State<InviteContactsSheet> {
  late List<int> selected;

  @override
  void initState() {
    selected = List.from(widget.initiallySelected);
    super.initState();
  }

  void toggle(int index) {
    setState(() {
      if (selected.contains(index)) {
        selected.remove(index);
      } else {
        selected.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
height: MediaQuery.of(context).size.height * 0.9,

      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// HANDLE + CLOSE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(Icons.close, size: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Invite your friends (${selected.length})",
                  style: const TextStyle(
                    fontFamily: "WorkSans",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C2A39),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// SEARCH BOX
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 58,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E7EB)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                        contentPadding: EdgeInsets.only(
                          top: 17,
                          bottom: 17,
                          right: 12,
                        ),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// CONTACTS LABEL
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF67707A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// LIST
            Expanded(
              child: ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (_, i) {
                  final c = widget.contacts[i];
                  final isSelected = selected.contains(i);

                  return InkWell(
                    onTap: () => toggle(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          /// CHECKBOX 24x24
Container(
  width: 24,
  height: 24,
  decoration: BoxDecoration(
    shape: BoxShape.rectangle, // 👈 square
    border: Border.all(
      color: isSelected
          ? const Color(0xFFFF5421)   // selected border
          : const Color(0xFF1C2A39),  // unselected border
      width: 1.5,
    ),
    color: isSelected
        ? const Color(0xFFFF5421)
        : Colors.transparent,
  ),
  child: isSelected
      ? const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        )
      : null,
),

                    
                          const SizedBox(width: 12),

                          /// NAME + PHONE
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c["name"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c["phone"]!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF67707A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDone(selected);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5421),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
