import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Future<void> showCustomCountryPicker({
  required BuildContext context,
  required List<Map<String, String>> countries,
  required int selectedIndex,
  required Function(int index, String code, String flagAsset) onSelect,
})
 {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              // =====================
              // TOP HANDLE + CLOSE
              // =====================
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================
              // SEARCH BAR (UI)
              // =====================
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon:
                          Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =====================
              // COUNTRY LIST
              // =====================
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                      final isSelected = index == selectedIndex;


                    return InkWell(
                      onTap: () {
                     onSelect(
                      index,
                      country['code']!,
                      country['asset']!,
                      );

                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        color: isSelected
                            ? const Color(0xFFF2F2F2)
                            : Colors.white,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              country['asset']!,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country['name']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    country['code']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color:
                                    Color(0xFFFF5421),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
