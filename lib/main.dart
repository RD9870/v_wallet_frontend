import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/providers/transfer_history_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/intro_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/loading_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/network_error_page.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/providers/home_provider.dart';
import 'package:v_wallet_frontend/providers/qr_provider.dart';
import 'package:v_wallet_frontend/screens/main_screens/main_view_screen.dart';


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
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => QrProvider()),
        ChangeNotifierProvider(create: (_) => TransferHistoryProvider()),
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
        return 
        authConsumer.hasInternet == false? NetworkErrorPage(onClick:(){
              Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).initAuthProvider();
        } ,):
        authConsumer.status == AuthStatus.authenticated
            ? MainViewScreen()
            : 
            authConsumer.status == AuthStatus.unauthenticated
            ? IntroScreen()
            : authConsumer.status == AuthStatus.authenticating
            ? LoadingScreen()
            : LoadingScreen();
        }
    );
      }
  }
