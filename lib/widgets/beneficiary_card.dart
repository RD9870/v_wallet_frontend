import 'package:flutter/material.dart'; // <-- هذا المهم

class BeneficiaryCard extends StatelessWidget {
  final String name;
  final String phone;

  const BeneficiaryCard({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text(phone),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            // لاحقًا: حذف beneficiary
          },
        ),
      ),
    );
  }
}
