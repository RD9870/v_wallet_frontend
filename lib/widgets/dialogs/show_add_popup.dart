import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/providers/beneficiary_provider.dart';
import 'package:v_wallet_frontend/widgets/transfer/add_beneficiary.dart';

class ShowAddPopup extends StatelessWidget {
  const ShowAddPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryProvider>(
      builder: (context, provider, _) {
        return AddBeneficiaryPopup(
          onAdd: (phone) async {
            final bool success = await provider.addBeneficiary(phone);

            if (!context.mounted) return;

            if (success) {
              if (context.mounted) Navigator.of(context).pop();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User not found"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}
