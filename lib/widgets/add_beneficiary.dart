import 'package:flutter/material.dart';

class AddBeneficiaryPopup extends StatelessWidget {
  final void Function(String name, String phone) onAdd;

  const AddBeneficiaryPopup({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return AlertDialog(
      title: const Text("Add Beneficiary"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: "Phone"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final phone = phoneController.text.trim();
            if (name.isNotEmpty && phone.isNotEmpty) {
              onAdd(name, phone);
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
