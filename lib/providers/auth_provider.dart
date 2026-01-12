import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  uninitialized,
  unauthenticated,
  authenticated,
  authenticating,
}

class AuthProvider extends BaseProvider {
  AuthStatus status = AuthStatus.uninitialized;
  String? token;
  TextEditingController nameController = TextEditingController(text: "test User");
  TextEditingController phoneController = TextEditingController(text: "0912345678");
  TextEditingController passwordController = TextEditingController(text: "password");
  TextEditingController confirmPasswordController = TextEditingController(text: "password");
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();




  Future<void> initAuthProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tempToken= prefs.getString("token");

    if (tempToken != null) {
      status = AuthStatus.authenticated;
      token = tempToken;
      if (kDebugMode) {
        print("TOKEN : $tempToken");
      }
    } else {
      status = AuthStatus.unauthenticated;
      token = null;
    }
    notifyListeners();
  }

 Future<List> register(Map body) async {
    setBusy(true);
    final response = await api.post("/register", body);
    if (response.statusCode == 201) {
      setFailed(false);
      setBusy(false);
      return [true, "User Registered Successfully"];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)['message']];
    }
  }




  Future<List> login(Map body) async {
    setBusy(true);
    final response = await api.post("/login", body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("token", json.decode(response.body)['access_token']);

      setFailed(false);
      setBusy(false);
      return [true, "User Loged Successfully"];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)['message']];
    }
  }

  Future<List> logout() async {
    setBusy(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await api.post("/logout", {});

    if (response.statusCode == 200) {
      prefs.remove("token");

      status = AuthStatus.unauthenticated;
      setFailed(false);

      setBusy(false);

      return [true, json.decode(response.body)["Message"]];
    } else {
      setFailed(true);
      setBusy(false);
      return [false, json.decode(response.body)["Message"]];
    }
  }


String? validateName(String? val){
  if (val!.isEmpty) {
  return "Name is Required";
}
return null;
}

String? validatePhone (String? val){
  if (val!.isEmpty) {
  return "Phone is Required";
}
if (val.length != 10) {
  return "Phone must be 10 digts at least";
}
return null;
}


String? validatePassword(String? val){
  if (val!.isEmpty) {
  return "Password is Required";
}
if (val.length < 8) {
  return "Password must be at least 10 digts long";
}
return null;
}


String? validateConfirmPassword(String? val){
  if (val!.isEmpty) {
  return "Password confirmation is Required";
}
if (val.length < 8) {
  return "Password must be at least 10 digts long";
}
if (val != passwordController.text) {
  return "Password confirmation must match passwrd";
}
return null;
}


void setHidePassword(){
  debugPrint("hidePassword =$hidePassword");
  debugPrint("!hidePassword =${!hidePassword}");
  hidePassword = !hidePassword;
  notifyListeners();
}

void setHideConfirmPassword(){
  hideConfirmPassword = !hideConfirmPassword;
  notifyListeners();
}
}