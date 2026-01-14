import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:v_wallet_frontend/providers/qr_provider.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QrProvider>(
      builder: (context, qrConsumer, _) {
        return QRView(
          key: qrConsumer.qrKey,
          onQRViewCreated: (controller) =>
              qrConsumer.onQRViewCreated(controller, context),
        );
      },
    );
  }
}
