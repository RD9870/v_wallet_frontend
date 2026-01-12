import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/screens/auth_screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.qr_code)),
            actions: [
              IconButton(
              icon: Icon(Icons.logout), onPressed:authConsumer.busy? null:  () async {
              final response = await authConsumer.logout();
              if (context.mounted) {
                          toastification.show(
                            type: response.first
                                ? ToastificationType.success
                                : ToastificationType.error,
                            title: Text(response.first ? "Success" : "Error"),
                            description: Text(response.last),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                        if (response.first && context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
            })],
          ),
          body: Center(child: Text("HOME SCREEN")),
        );
    });
  }
}