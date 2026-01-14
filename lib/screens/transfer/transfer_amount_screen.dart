import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/providers/transfer_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/confirmation_page.dart';

class TransferAmountScreen extends StatefulWidget {
  final String receiverPhone;

  const TransferAmountScreen({super.key, required this.receiverPhone});

  @override
  State<TransferAmountScreen> createState() => TransferAmountScreenState();
}

class TransferAmountScreenState extends State<TransferAmountScreen> {
  final TextEditingController amountController = TextEditingController();
  final List<int> presets = [10, 20, 30, 40, 50, 60, 100, 150];

  @override
  Widget build(BuildContext context) {
    final transferProvider = context.watch<TransferProvider>();

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
                                  controller: amountController,
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
                            children: presets
                                .map((amount) => buildPresetChip(amount))
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
                  onPressed: transferProvider.isLoading ? null : handleTransfer,
                  child: transferProvider.isLoading
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
  }

  Widget buildPresetChip(int amount) {
    return InkWell(
      onTap: () {
        setState(() {
          amountController.text = amount.toString();
        });
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
  }

  void handleTransfer() async {
    final amountText = amountController.text.trim();
    if (amountText.isEmpty) return;

    final double? amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      showSnackBar("Please enter a valid amount", isError: true);
      return;
    }

    final response = await context.read<TransferProvider>().sendMoney(
      phone: widget.receiverPhone,
      amount: amount,
    );

    if (!mounted) return;
    final transferData = response!["data"];
    ConfirmationPage(
      message: response["message"].toString(), // رسالة النجاح من المستوى الأول
      // تأكد من تحويل المبلغ لنوع رقمي إذا كانت الصفحة تتوقعه int أو double
      ammount: transferData["amount"].toString(),

      // المفتاح في الـ API هو 'sender_balance' وليس 'current_balance'
      currentBalance: transferData["sender_balance"].toString(),

      // المفتاح في الـ API هو 'date'
      date: transferData["date"].toString(),

      // المفتاح في الـ API هو 'transfer_id' وليس 'transaction_id'
      transactionId: transferData["transfer_id"].toString(),
    );

    // if (error == null) {
    //   // showSuccessDialog();
    // } else {
    //   showSnackBar(error, isError: true);
    // }
  }

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Transfer Completed Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
