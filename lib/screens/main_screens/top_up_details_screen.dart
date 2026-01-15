import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';
import 'package:v_wallet_frontend/providers/topup_provider.dart';

class TopUpDetailsScreen extends StatefulWidget {
  final int bankId;
  final String bankName;
  final String logoPath;

  const TopUpDetailsScreen({
    super.key,
    required this.bankId,
    required this.bankName,
    required this.logoPath,
  });

  @override
  State<TopUpDetailsScreen> createState() => _TopUpDetailsScreenState();
}

class _TopUpDetailsScreenState extends State<TopUpDetailsScreen> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.bankName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<TopUpProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                // Bank logo
                Image.asset(widget.logoPath, height: 80),
                const SizedBox(height: 24),

                // Account Number Field
                TextField(
                  controller: accountController,
                  decoration: InputDecoration(
                    labelText: "Account Number",
                    errorText: provider.accountError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // PIN Field
                TextField(
                  controller: pinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "PIN",
                    errorText: provider.pinError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Amount Field
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    errorText: provider.amountError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Button or Loading
                provider.isLoading
                    ? const CircularProgressIndicator()
                    : MainButton(
                        backgroundColor: primaryColor,
                        label: 'Confirm Top Up',
                        onTap: () async {
                          // Validate fields
                          final isValid = provider.validate(
                            accountController.text,
                            pinController.text,
                            amountController.text,
                          );
                          if (!isValid) return;

                          // Perform Top-Up (token auto-read from SharedPreferences)
                          final success = await provider.performTopUp(
                            widget.bankId,
                            accountController.text,
                            pinController.text,
                            amountController.text,
                          );

                          // Show result
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success ? "Top up successful" : "Top up failed",
                              ),
                              backgroundColor: success
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          );
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
