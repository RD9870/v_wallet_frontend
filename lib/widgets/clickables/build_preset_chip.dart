import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/providers/transfer_provider.dart';

class BuildPresetChip extends StatelessWidget {
  final int amount;

  const BuildPresetChip({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransferProvider>(
      builder: (context, provider, _) {
        return InkWell(
          onTap: () {
            provider.setAmount(amount);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "$amount LYD",
              style: labelSmall.copyWith(color: Colors.black87, fontSize: 13),
            ),
          ),
        );
      },
    );
  }
}
