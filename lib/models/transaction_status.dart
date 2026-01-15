import 'package:flutter/services.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

enum TransactionStatus {
  completed(label: "Completed", textColor: greenColor),

  pending(label: "Pending", textColor: orangeColor),

  expired(label: "Expired", textColor: redColor);

  final String label;
  final Color textColor;

  const TransactionStatus({required this.label, required this.textColor});
}
