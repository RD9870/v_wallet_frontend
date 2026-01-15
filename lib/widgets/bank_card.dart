import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final String bankName;
  final String logoPath;
  final bool isSelected;
  final VoidCallback onTap;

  const BankCard({
    super.key,
    required this.bankName,
    required this.logoPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isSelected ? 6 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(logoPath, width: 50, height: 50),
              const SizedBox(width: 16),
              Text(
                bankName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
