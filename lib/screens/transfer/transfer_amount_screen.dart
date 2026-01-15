import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/providers/transfer_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/confirmation_page.dart';
import 'package:v_wallet_frontend/widgets/clickables/build_preset_chip.dart';
import 'package:v_wallet_frontend/widgets/statics/show_snack_bar.dart';

class TransferAmountScreen extends StatefulWidget {
  final String receiverPhone;

  const TransferAmountScreen({super.key, required this.receiverPhone});

  @override
  State<TransferAmountScreen> createState() => TransferAmountScreenState();
}

class TransferAmountScreenState extends State<TransferAmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransferProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Type Transfer Amount",
                          style: labelExtraLarge.copyWith(
                            color: Colors.black,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: provider.amountController,
                                      keyboardType: TextInputType.number,
                                      style: labelExtraLarge.copyWith(
                                        color: Colors.black,
                                        fontSize: 40,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "0",
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "LYD",
                                    style: labelMedium.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "Or Select From the following",
                                style: bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),

                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: provider.presets
                                    .map(
                                      (amount) =>
                                          BuildPresetChip(amount: amount),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      onPressed: provider.busy
                          ? null
                          : () async {
                              //handleTransfer
                              final response = await provider.sendMoney(
                                phone: widget.receiverPhone,
                                amount: double.tryParse(
                                  provider.amountController.text,
                                )!,
                              );

                              if (!mounted) return;

                              if (response != null &&
                                  response["data"] != null) {
                                final transferData = response["data"];

                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfirmationPage(
                                        message: response["message"].toString(),
                                        ammount: transferData["amount"]
                                            .toString(),
                                        currentBalance:
                                            transferData["sender_balance"]
                                                .toString(),
                                        date: transferData["date"].toString(),
                                        transactionId:
                                            transferData["transfer_id"]
                                                .toString(),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                ShowSnackBar(
                                  message: "Transfer failed, please try again.",
                                  isError: true,
                                );
                              }
                            },
                      child: provider.busy
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Transfer Amount",
                              style: labelMedium.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
