import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/models/transaction_detail_type.dart';
import 'package:v_wallet_frontend/models/transaction_status.dart';
import 'package:v_wallet_frontend/models/transaction_type.dart';
import 'package:v_wallet_frontend/widgets/dialogs/transaction_detail_pop_up.dart';

class TransactionTile extends StatelessWidget {
  final TransactionType type;
  final int amount;
  final String date;
  const TransactionTile({
    super.key,
    required this.type,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => TransactionDetailPopUp(
            type: TransactionDetailType.topUp,
            dateTime: "19 feb 2002",
            status: TransactionStatus.pending,
            amount: 300,
          ),
        );
      },
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(color: blackColor.withValues(alpha: 0.13)),

              BoxShadow(
                color: type.backgroundColor,
                blurRadius: 5,
                spreadRadius: -2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(type.icon, color: type.iconColor),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              textAlign: TextAlign.start,
            ),
            Text(
              type.label,
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
            Text(
              "${type.prefix} $amount LYD",
              style: TextStyle(color: type.textColor),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
