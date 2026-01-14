import 'package:flutter/material.dart';

class BeneficiaryCard extends StatelessWidget {
  final String name;
  final String phone;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const BeneficiaryCard({
    super.key,
    required this.name,
    required this.phone,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: const Icon(
            Icons.account_circle,
            size: 45,
            color: Colors.black,
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(phone),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
