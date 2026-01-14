import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:v_wallet_frontend/providers/qr_transfer_provider.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan to Receive")),
      body: Consumer<QrTransferProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              QRView(
                key: provider.qrKey,
                onQRViewCreated: (controller) =>
                    provider.onQRViewCreated(controller, context),
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
              if (provider.isProcessing)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          );
        },
      ),
    );
  }
}
