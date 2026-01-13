import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';
import 'package:v_wallet_frontend/widgets/statics/message_data_text.dart';

class ConfirmationPage extends StatelessWidget {
  final String message;
  final String? transactionId;
  final String? date;
  final int? ammount;
  final int? currentBalance;

  const ConfirmationPage({super.key, required this.message,
  this.transactionId,
  this.date,
  this.ammount,
  this.currentBalance,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Container(
                height: getSize(context).shortestSide * 0.5,
                width: getSize(context).shortestSide * 0.5,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(200))
                ),
                child: Icon(Icons.check_rounded, color: whiteColor, size: getSize(context).shortestSide * 0.5,),
              ),
            ),
            Text(message, style: labelExtraLarge,),
            MessageDataText(mainText: "Transaction ID", subText: transactionId !=null ? transactionId! :"id"),
            MessageDataText(mainText: "Date", subText: date != null ? date! : "1/1/1",),
            MessageDataText(mainText: "Amount", subText: ammount != null ? "${ammount!} LYD" : "0 LYD",),
            MessageDataText(mainText: "Current Balance", subText: currentBalance != null ? "${currentBalance!} LYD" : "0 LYD",),
            MainButton(backgroundColor: primaryColor, label: "Done", onTap: (){
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }
}