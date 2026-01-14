import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/services/api.dart';

class TransferProvider with ChangeNotifier {
  final Api api = Api();
  bool isLoadings = false;

  bool get isLoading => isLoadings;

  Future<Map<String, dynamic>?> sendMoney({
    required String phone,
    required double amount,
  }) async {
    isLoadings = true;
    notifyListeners();

    try {
      final response = await api.post("/transfers-phone", {
        "receiver_phone": phone,
        "amount": amount.toString(),
      });

      final responseData = jsonDecode(response.body);
      debugPrint("Transfer response: $responseData");
      if (response.statusCode == 200) {
        isLoadings = false;
        notifyListeners();
        return responseData;
      } else {
        isLoadings = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoadings = false;
      notifyListeners();
      return null;
    }
  }
}
