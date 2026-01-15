import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<http.Response> get(String endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    final response = await http.get(
      Uri.parse("$baseUrl$endPoint"),

      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (kDebugMode) {
      print("RESPONSE GET : $baseUrl$endPoint");
      print("TOKEN IN GET : $token");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<http.Response> post(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.post(
      Uri.parse("$baseUrl$endPoint"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: body,
    );

    if (kDebugMode) {
      print("RESPONSE POST : $baseUrl$endPoint");
      print("TOKEN IN POST : $token");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<http.Response> put(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.put(
      Uri.parse("$baseUrl$endPoint"),
      body: body,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    if (kDebugMode) {
      print("RESPONSE PUT : $baseUrl$endPoint");
      print("TOKEN IN PUT : $token");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }
    return response;
  }

  Future<http.Response> delete(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await http.delete(
      Uri.parse("$baseUrl$endPoint"),
      body: body,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    if (kDebugMode) {
      print("RESPONSE DELETE : $baseUrl$endPoint");
      print("TOKEN IN DELETE : $token");
      print("RESPONSE STATUS CODE : ${response.statusCode}");
      print("RESPONSE BODY : ${response.body}");
    }

    return response;
  }
}
