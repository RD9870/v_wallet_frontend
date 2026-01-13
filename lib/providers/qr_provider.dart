import 'dart:convert';

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

  Future<bool> validateTransaction() async {
    //    "uuid": "a5da4997-4e9c-41c8-a1b3-48f3abb2743f", //"45050d57-3054-428d-a1c2-86df90624c7d",
    // "amount": 1
    final response = await api.post("/vendor/wallets/validate", {
      "uuid": qrValue,
      //TODO Change ammount to test
      "amount": "10", //"10000000000000",
    });
    final data = jsonDecode(response.body);
    // if (data["can_transaction"] == true) {
    //   return true;
    // }
    debugPrint("can_transaction: ${data["data"]["can_transaction"]}");
    if (data["data"]["can_transaction"] == true) {
      qrs.add(qrValue!);
    }
    notifyListeners();
    return data["data"]["can_transaction"];
  }
}
