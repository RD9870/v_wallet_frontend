import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';

class TransactionDetailPopUp extends StatelessWidget {

  final TransactionDetailType type;
  final TransactionStatus status;
  final String dateTime;
  final int amount;
  final String? bank;
  final String? account;
  final String? from;
  final String? to;

  const TransactionDetailPopUp({super.key, required this.type, required this.amount,
  required this.dateTime,
  required this.status,
    this.bank,
    this.account,
    this.from,
    this.to,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              )
            ],
          ),
          Container(
              height: getSize(context).height* 0.07,
              width: getSize(context).height * 0.07,
              decoration: BoxDecoration(
              shape: BoxShape.circle,      
              boxShadow: [
                BoxShadow(
                color: blackColor.withValues(alpha: 0.13)        
              ),
              
              BoxShadow(
                color: type.backgroundColor,
                blurRadius: 5,
                spreadRadius: -2
              )],
              ),
              child: Icon(type.icon, color: type.iconColor),
            ),
        ],
      ),

      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${type.prefix}$amount LYD"),
          Divider(),
          Text("Status: ${status.label}"), 
          Text("Date: $dateTime"), 
          type == TransactionDetailType.topUp?   Text("Bank: $bank") : type == TransactionDetailType.received? Text("From: $from")
              : type == TransactionDetailType.transfered
              ? Text("To: $to")
              : SizedBox(),
          type == TransactionDetailType.topUp? Text("Account: $account") : SizedBox(),
        ]
      ),
    );
  }
}





enum TransactionDetailType {
  received(
    // label: "Received",
    icon: Icons.south_west,
    iconColor: recivedIconColor,
    // textColor: recivedMoneyColor,
    backgroundColor: recivedIconBackground,
    prefix: "+",
  ),
  transfered(
    // label: "Transferred",
    icon: Icons.arrow_outward,
    iconColor: transferIconColor,
    // textColor: transferMoneyColor,
    backgroundColor: transferIconBackground,
    prefix: "-",
  ),

  topUp(
    icon: Icons.south_west,
    iconColor: recivedIconColor,
    backgroundColor: recivedIconBackground,
    prefix: "+",
  );

  // Fields
   //
  // final String label;

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String prefix;

  // Constructor
  const TransactionDetailType({    
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.prefix,
  });
}



 //status date & time  bank    Account      From          To




 enum TransactionStatus {
  completed(
    label: "Completed",
    textColor: greenColor,
  ),

  pending(
    label: "Pending",
    textColor: orangeColor,
  ),

  failed(
    label: "Failed",
    textColor: redColor,
  );

  // Fields
  //
  final String label;
  final Color textColor;


  // Constructor
  const TransactionStatus({
    required this.label,
    required this.textColor,
  });
}
