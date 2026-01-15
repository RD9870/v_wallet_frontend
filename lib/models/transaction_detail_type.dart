import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

enum TransactionDetailType {
  received(
    icon: Icons.south_west,
    iconColor: recivedIconColor,
    backgroundColor: recivedIconBackground,
    prefix: "+",
  ),
  transfered(
    icon: Icons.arrow_outward,
    iconColor: transferIconColor,
    backgroundColor: transferIconBackground,
    prefix: "-",
  ),

  topUp(
    icon: Icons.south_west,
    iconColor: recivedIconColor,
    backgroundColor: recivedIconBackground,
    prefix: "+",
  );

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String prefix;

  const TransactionDetailType({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.prefix,
  });
}
