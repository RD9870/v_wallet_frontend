import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center( child:  CircularProgressIndicator(
      color: primaryColor,
    ),);
  }
}