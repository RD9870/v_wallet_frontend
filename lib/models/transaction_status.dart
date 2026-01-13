import 'package:flutter/services.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

enum TransactionStatus {
  completed(label: "Completed", textColor: greenColor),

  pending(label: "Pending", textColor: orangeColor),

  failed(label: "Failed", textColor: redColor);

  // Fields
  //
  final String label;
  final Color textColor;

  // Constructor
  const TransactionStatus({required this.label, required this.textColor});
}
