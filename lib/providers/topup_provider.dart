import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/consts.dart';

class TopUpProvider extends ChangeNotifier {
  bool isLoading = false;

  // Validation error messages
  String? accountError;
  String? pinError;
  String? amountError;

  // Validate fields
  bool validate(String account, String pin, String amount) {
    bool isValid = true;

    accountError = null;
    pinError = null;
    amountError = null;

    if (account.isEmpty) {
      accountError = "Account number is required";
      isValid = false;
    }

    if (pin.isEmpty) {
      pinError = "PIN is required";
      isValid = false;
    }

    if (amount.isEmpty) {
      amountError = "Amount is required";
      isValid = false;
    } else {
      final numValue = num.tryParse(amount);
      if (numValue == null || numValue <= 0) {
        amountError = "Enter a valid amount";
        isValid = false;
      }
    }

    notifyListeners();
    return isValid;
  }

  // Get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Perform Top-Up using token from SharedPreferences
  Future<bool> performTopUp(
    int bankId,
    String account,
    String pin,
    String amount,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await _getToken();
      if (token == null) {
        isLoading = false;
        notifyListeners();
        debugPrint("No token found!");
        return false;
      }

      final url = Uri.parse('$baseUrl/top-ups'); // Laravel endpoint
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "bank_id": bankId,
          "account_number": account,
          "pin": pin,
          "amount": amount,
        }),
      );

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      } else {
        debugPrint("Server error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("Top-up exception: $e");
      return false;
    }
  }
}
