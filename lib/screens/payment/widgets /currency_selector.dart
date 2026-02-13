import 'package:flutter/material.dart';

enum CurrencyType { inr, gbp }

class CurrencySelector extends StatelessWidget {
  final CurrencyType selectedCurrency;
  final ValueChanged<CurrencyType> onChanged;

  const CurrencySelector({
    super.key,
    required this.selectedCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose currency:',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 13,
            color: Color(0xFF6B6B6B),
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _CurrencyCard(
                isSelected: selectedCurrency == CurrencyType.inr,
                flagPath: 'assets/images/india1.png',
                amount: '₹ 573.64',
                onTap: () => onChanged(CurrencyType.inr),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CurrencyCard(
                isSelected: selectedCurrency == CurrencyType.gbp,
                flagPath: 'assets/images/uk1.png',
                amount: '£ 350.00',
                onTap: () => onChanged(CurrencyType.gbp),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        const Text(
          '1 GBP = 120.96 INR (include 4% conversion fee)',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 12,
            color: Color(0xFF6B6B6B),
          ),
        ),
      ],
    );
  }
}

class _CurrencyCard extends StatelessWidget {
  final bool isSelected;
  final String flagPath;
  final String amount;
  final VoidCallback onTap;

  const _CurrencyCard({
    required this.isSelected,
    required this.flagPath,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.only(left: 12, right: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF5A1F)
                : const Color(0xFFECECEC),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                flagPath,
                width: 33,
                height: 22,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              amount,
              style: const TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C2A39),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
