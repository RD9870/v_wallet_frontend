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
            actions: [IconButton(
              icon: Icon(Icons.logout), onPressed:authConsumer.busy? null:  () async {
              final response = await authConsumer.logout();
debugPrint("out of toast: $response");
              if (context.mounted) {
                debugPrint("in toast: $response");
                          toastification.show(
                            type: response.first
                                ? ToastificationType.success
                                : ToastificationType.error,
                            title: Text(response.first ? "Success" : "Error"),
                            description: Text(response.last),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        }
                        debugPrint("response.first && context.mounted: ${response.first && context.mounted}");
                        debugPrint("response.first: $response.first");
                        debugPrint("context.mounted: $context.mounted");
                        if (response.first && context.mounted) {
                          debugPrint("in navigation: $response");
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