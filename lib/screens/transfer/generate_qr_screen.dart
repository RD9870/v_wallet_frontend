import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/providers/qr_transfer_provider.dart';

class GenerateQrScreen extends StatefulWidget {
  const GenerateQrScreen({super.key});

  @override
  State<GenerateQrScreen> createState() => GenerateQrScreenState();
}

class GenerateQrScreenState extends State<GenerateQrScreen> {
  final TextEditingController amountController = TextEditingController(
    text: "0",
  );
  final List<String> quickAmounts = [
    "10",
    "20",
    "30",
    "40",
    "50",
    "60",
    "100",
    "150",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: Consumer<QrTransferProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  "Type Transfer Amount",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Text(
                            "LYD",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        "Or Select From the following",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: quickAmounts
                            .map(
                              (amt) => ActionChip(
                                label: Text("$amt LYD"),
                                backgroundColor: const Color(0xFFFFDADA),
                                onPressed: () =>
                                    setState(() => amountController.text = amt),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                if (provider.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF06C71),
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final bool? confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("confirm QR Code Generation"),
                          content: Text(
                            "Are you sure you want to generate a QR code for ${amountController.text}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text("cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text("confirm"),
                            ),
                          ],
                        ),
                      );
                      if (confirmed != true) return;
                      if (context.mounted) {
                        await provider.generateQr(
                          amountController.text,
                          context,
                        );

                        if (provider.generatedQrData != null &&
                            context.mounted) {
                          provider.showQrResult(
                            context,
                            provider.generatedQrData!,
                          );
                        }
                      }
                    },

                    child: const Text(
                      "Generate QR Code",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
