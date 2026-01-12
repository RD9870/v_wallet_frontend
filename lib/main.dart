import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/confirmation_page.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/intro_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/loading_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/network_error_page.dart';
import 'package:v_wallet_frontend/screens/main_screens/home_screen.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //TODO Add providers here
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: ToastificationWrapper(
  child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const ScreenRouter(),
      ),),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return authConsumer.status == AuthStatus.authenticated
            ? NetworkErrorPage()//ConfirmationPage(message: "DONE",)//HomeScreen()
            : authConsumer.status == AuthStatus.unauthenticated
            ? IntroScreen()
            : authConsumer.status == AuthStatus.authenticating
            ? LoadingScreen()
            : LoadingScreen();
        }
    );
      }
  }
