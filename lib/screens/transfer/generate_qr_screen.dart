import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:v_wallet_frontend/providers/qr_transfer_provider.dart';

class GenerateQrScreen extends StatefulWidget {
  const GenerateQrScreen({super.key});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: "200",
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
                // صندوق الإدخال
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
                              controller: _amountController,
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
                                onPressed: () => setState(
                                  () => _amountController.text = amt,
                                ),
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
                      await provider.generateQr(
                        _amountController.text,
                        context,
                      );
                      if (provider.generatedQrData != null) {
                        _showQrResult(context, provider.generatedQrData!);
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

  void _showQrResult(BuildContext context, String qrData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Let The Other Party\nScan the Code",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            QrImageView(data: qrData, version: QrVersions.auto, size: 250),
            const SizedBox(height: 20),
            const Text(
              "12-34-56-789",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
