import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/confirmation_page.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/intro_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/loading_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/network_error_page.dart';
import 'package:v_wallet_frontend/screens/main_screens/beneficiaries_screen.dart';
import 'package:v_wallet_frontend/screens/main_screens/home_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/services/connectivity_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const BeneficiariesScreen());
  }
}
