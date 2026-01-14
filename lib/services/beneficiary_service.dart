import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class BeneficiaryService {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<List<Map<String, dynamic>>> getBeneficiaries() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/beneficiaries"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw Exception("Failed to load beneficiaries");
    }
  }

  Future<void> addBeneficiary(String name, String phone) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/beneficiaries"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {"name": name, "phone": phone},
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add beneficiary");
    }
  }

  Future<void> deleteBeneficiary(String id) async {
    final token = await getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/beneficiaries/$id"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete beneficiary");
    }
  }
}
