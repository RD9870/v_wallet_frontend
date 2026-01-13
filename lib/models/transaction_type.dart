import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

enum TransactionType {
  received(
    label: "Received",
    icon: Icons.south_west,
    iconColor: recivedIconColor,
    textColor: recivedMoneyColor,
    backgroundColor: recivedIconBackground,
    prefix: "+",
  ),
  transfered(
    label: "Transferred",
    icon: Icons.arrow_outward,
    iconColor: transferIconColor,
    textColor: transferMoneyColor,
    backgroundColor: transferIconBackground,
    prefix: "-",
  );

  // Fields
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final String prefix;

  // Constructor
  const TransactionType({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.backgroundColor,
    required this.prefix,
  });
}
