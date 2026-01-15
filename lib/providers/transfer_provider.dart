import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';

class TransferProvider extends BaseProvider {
  final TextEditingController amountController = TextEditingController();
  final List<int> presets = [10, 20, 30, 40, 50, 60, 100, 150];

  Future<Map<String, dynamic>?> sendMoney({
    required String phone,
    required double amount,
  }) async {
    setBusy(true);

    try {
      final response = await api.post("/transfers-phone", {
        "receiver_phone": phone,
        "amount": amount.toString(),
      });

      final responseData = jsonDecode(response.body);
      debugPrint("Transfer response: $responseData");
      if (response.statusCode == 200) {
        setBusy(false);
        return responseData;
      } else {
        setBusy(false);
        return null;
      }
    } catch (e) {
      setBusy(false);
      return null;
    }
  }

  void setAmount(int amount) {
    amountController.text = amount.toString();
    notifyListeners();
  }

  Future<String?> handleTransfer() async {
    final amountText = amountController.text.trim();
    if (amountText.isEmpty) return "Text field is empty";

    final double? amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      return "Please enter a valid amount";
    }

    return null;
  }
}
