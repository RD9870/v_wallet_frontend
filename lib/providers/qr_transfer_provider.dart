import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:v_wallet_frontend/services/api.dart';

class QrTransferProvider extends ChangeNotifier {
  final Api api = Api();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isProcessing = false;

  bool isLoading = false;
  String? generatedQrData;

  Future<void> generateQr(String amount, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await api.post("/generate-qr", {"amount": amount});

      if (!context.mounted) return;

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        generatedQrData = data['qr_data'];
        notifyListeners();
      } else {
        showError(context, data['error'] ?? "Failed to generate QR code");
      }
    } catch (e) {
      if (!context.mounted) return;
      showError(context, " Error in generating QR code");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (isProcessing) return;

      if (scanData.code != null) {
        isProcessing = true;
        await controller.pauseCamera();
        if (!context.mounted) return;
        handleScannedData(scanData.code!, context);
      }
    });
  }

  void handleScannedData(String code, BuildContext context) async {
    try {
      Map<String, dynamic> data = jsonDecode(code);
      String qrRequestId = data['qr_request_id'];
      String amount = data['amount'].toString();

      if (!context.mounted) return;

      final response = await api.post("/transfers-qr", {
        "qr_request_id": qrRequestId,
      });

      if (!context.mounted) return;
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSuccess(context, "success transfer $amount LYD ");
        Navigator.pop(context);
      } else {
        showError(context, result['error'] ?? "failed to process transfer");
        resumeScanning();
      }
    } catch (e) {
      if (context.mounted) {
        showError(context, "Invalid QR code");
      }
      resumeScanning();
    }
  }

  void resumeScanning() async {
    await controller?.resumeCamera();
    isProcessing = false;
  }

  void showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  void showSuccess(BuildContext context, String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green));
  }

  void showQrResult(BuildContext context, String qrData) {
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
