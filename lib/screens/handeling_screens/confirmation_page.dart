import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/screens/transfer/beneficiaries_screen.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';
import 'package:v_wallet_frontend/widgets/statics/message_data_text.dart';

class ConfirmationPage extends StatelessWidget {
  final String message;
  final String? transactionId;
  final String? date;
  final String? ammount;
  final String? currentBalance;

  const ConfirmationPage({
    super.key,
    required this.message,
    this.transactionId,
    this.date,
    this.ammount,
    this.currentBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    height: getSize(context).shortestSide * 0.5,
                    width: getSize(context).shortestSide * 0.5,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: whiteColor,
                      size: getSize(context).shortestSide * 0.5,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(message, style: labelExtraLarge),

                const SizedBox(height: 16),

                MessageDataText(
                  mainText: "Transaction ID",
                  subText: transactionId ?? "id",
                ),
                MessageDataText(mainText: "Date", subText: date ?? "1/1/1"),
                MessageDataText(
                  mainText: "Amount",
                  subText: "${ammount ?? 0} LYD",
                ),
                MessageDataText(
                  mainText: "Current Balance",
                  subText: "${currentBalance ?? 0} LYD",
                ),

                const SizedBox(height: 24),

                MainButton(
                  backgroundColor: primaryColor,
                  label: "Done",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BeneficiariesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
