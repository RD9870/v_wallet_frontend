import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class AddBeneficiaryPopup extends StatelessWidget {
  final Function(String phone) onAdd;
  final TextEditingController phoneController = TextEditingController();

  AddBeneficiaryPopup({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Add Beneficiary",
        style: labelMedium.copyWith(color: blackColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Enter the phone number to add the user.", style: bodyMedium),
          const SizedBox(height: 15),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Phone Number",
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: bodyMedium.copyWith(color: grayColor)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          ),
          onPressed: () {
            if (phoneController.text.trim().isNotEmpty) {
              onAdd(phoneController.text.trim());
            }
          },
          child: Text("Add", style: labelSmall.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
