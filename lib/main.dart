import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/providers/qr_transfer_provider.dart';
import 'package:v_wallet_frontend/providers/home_provider.dart';
import 'package:v_wallet_frontend/providers/transfer_history_provider.dart';
import 'package:v_wallet_frontend/providers/topup_provider.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/intro_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/loading_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/network_error_page.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/screens/main_screens/main_view_screen.dart';
import 'package:v_wallet_frontend/providers/beneficiary_provider.dart';
import 'package:v_wallet_frontend/providers/transfer_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => QrTransferProvider()),
        ChangeNotifierProvider(create: (_) => TransferHistoryProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BeneficiaryProvider()),
        ChangeNotifierProvider(create: (_) => TransferProvider()),
        ChangeNotifierProvider(create: (_) => TopUpProvider()),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          ),
          home: const ScreenRouter(),
        ),
      ),
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
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        // return authConsumer.hasInternet == false
        //     ? NetworkErrorPage(
        //         onClick: () {
        //           Provider.of<AuthProvider>(
        //             context,
        //             listen: false,
        //           ).initAuthProvider();
        //         },
        //       )
        //     : authConsumer.status == AuthStatus.authenticated
        //     ? MainViewScreen()
        //     : authConsumer.status == AuthStatus.unauthenticated
        //     ? IntroScreen()
        //     : authConsumer.status == AuthStatus.authenticating
        //     ? LoadingScreen()
        //     : LoadingScreen();
        if (authConsumer.hasInternet == false) {
          return NetworkErrorPage(
            onClick: () {
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).initAuthProvider();
            },
          );
        }

        switch (authConsumer.status) {
          case AuthStatus.authenticated:
            return const MainViewScreen();
          case AuthStatus.unauthenticated:
            return const IntroScreen();
          case AuthStatus.authenticating:
          default:
            return const LoadingScreen();
        }
      },
    );
  }
}
