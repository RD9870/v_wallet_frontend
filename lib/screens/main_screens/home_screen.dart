import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/models/transaction_type.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/providers/home_provider.dart';
import 'package:v_wallet_frontend/screens/auth_screens/login_screen.dart';
import 'package:v_wallet_frontend/screens/handeling_screens/qr_scanner.dart';
import 'package:v_wallet_frontend/screens/main_screens/transfer_history.dart';
import 'package:v_wallet_frontend/widgets/clickables/transaction_tile.dart';
import 'package:v_wallet_frontend/widgets/statics/colored_container.dart';
import 'package:v_wallet_frontend/widgets/statics/message_data_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, HomeProvider>(
      builder: (context, authConsumer, homeConsumer, _) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                ColoredContainer(
                  kids: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //TODO QR scanner
                          IconButton(
                            onPressed: () async {
                              final scannedCode = await Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => const QrScanner(),
                                    ),
                                  );
                              debugPrint("scannedCode: $scannedCode");
                            },
                            icon: Icon(
                              Icons.qr_code,
                              color: whiteColor,
                              size: getSize(context).width * 0.1,
                            ),
                          ),

                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: whiteColor,
                              size: getSize(context).width * 0.1,
                            ),
                            onPressed: authConsumer.busy
                                ? null
                                : () async {
                                    final response = await authConsumer
                                        .logout();
                                    if (context.mounted) {
                                      toastification.show(
                                        type: response.first
                                            ? ToastificationType.success
                                            : ToastificationType.error,
                                        title: Text(
                                          response.first ? "Success" : "Error",
                                        ),
                                        description: Text(response.last),
                                        autoCloseDuration: const Duration(
                                          seconds: 5,
                                        ),
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
                                  },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            color: whiteColor,
                            size: getSize(context).width * 0.2,
                          ),
                          Text(
                            "Hello, username",
                            style: labelLarge.copyWith(color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                    MessageDataText(
                      mainText: "Current Balance",
                      subText: "00000 LYD",
                      color: whiteColor,
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return TransactionTile(
                        amount: 333,
                        date: "13 Dec 1969",
                        type: TransactionType.received,
                      );
                    },
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TransferHistory(),
                      ),
                    );
                  },
                  child: Text("See Transfer History>>>>>"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
