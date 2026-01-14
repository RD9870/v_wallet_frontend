import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';

class QrProvider extends BaseProvider {
  String? qrValue;
  GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  bool hasScanned = false;
  List<String> qrs = [];

  // Future<void> showQrScanner() async {}

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    hasScanned = false;
    controller.scannedDataStream.listen((scanData) async {
      qrValue = scanData.code;
      if (hasScanned) return;
      hasScanned = true;
      await controller.pauseCamera();
      if (context.mounted) {
        Navigator.pop(context, scanData.code); // Exit the scanner screen
      }
      debugPrint("qr: $qrValue");
      notifyListeners();
    });
  }
}
