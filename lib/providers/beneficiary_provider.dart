import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/models/beneficiary_model.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';

class BeneficiaryProvider extends BaseProvider {
  List<Beneficiary> beneficiariess = [];
  final TextEditingController manualPhoneController = TextEditingController();
  String? errorMessage;
  String cleanPhone = '';

  bool isValidating = false;

  Future<void> navigateToTransfer(String phone) async {
    cleanPhone = phone.trim();
    debugPrint("Clean Phone: $cleanPhone");
    debugPrint("cleanPhone.isEmpty: ${cleanPhone.isEmpty}");

    if (cleanPhone.isEmpty) {
      errorMessage = "Please enter a phone number";
    } else {
      setisValidating(true);
      errorMessage = await verifyReceiver(cleanPhone);
      setisValidating(false);
    }

    notifyListeners();
  }

  void setisValidating(bool value) {
    isValidating = value;
    notifyListeners();
  }

  Future<String?> verifyReceiver(String phone) async {
    try {
      final response = await api.get("/verify-receiver/$phone");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return null;
      } else {
        return responseData['message'] ?? "Invalid phone number";
      }
    } catch (e) {
      debugPrint("Verify Error: $e");
      return "Connection error. Please try again later.";
    }
  }

  Future<void> fetchBeneficiaries() async {
    setBusy(true);
    notifyListeners();
    try {
      final response = await api.get("/beneficiaries");
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);
        beneficiariess = decodedData
            .map((item) => Beneficiary.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint("Fetch Error: $e");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<bool> addBeneficiary(String phone) async {
    try {
      final response = await api.post("/beneficiaries", {"phone": phone});
      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchBeneficiaries();
        return true;
      }
    } catch (e) {
      debugPrint("Add Error: $e");
    }
    return false;
  }

  Future<void> deleteBeneficiary(int beneficiaryId) async {
    try {
      final response = await api.delete("/beneficiaries/$beneficiaryId", {});
      if (response.statusCode == 200) {
        beneficiariess.removeWhere(
          (item) => item.beneficiaryId == beneficiaryId,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Delete Error: $e");
    }
  }
}
