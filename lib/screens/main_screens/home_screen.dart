import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/providers/home_provider.dart';
import 'package:v_wallet_frontend/screens/auth_screens/login_screen.dart';
import 'package:v_wallet_frontend/screens/main_screens/transfer_history.dart';
import 'package:v_wallet_frontend/screens/transfer/scan_qr_screen.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getUserInfo();
      Provider.of<HomeProvider>(context, listen: false).poplateHome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, HomeProvider>(
      builder: (context, authConsumer, homeConsumer, _) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                ColoredContainer(
                  kids: homeConsumer.busy
                      ? [
                          SizedBox(
                            height: getSize(context).height * 0.3,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final scannedCode =
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const QrScannerScreen(),
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
                                                response.first
                                                    ? "Success"
                                                    : "Error",
                                              ),
                                              description: Text(response.last),
                                              autoCloseDuration: const Duration(
                                                seconds: 5,
                                              ),
                                            );
                                          }
                                          if (response.first &&
                                              context.mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
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
                                  "Hello, ${homeConsumer.username}",
                                  style: labelLarge.copyWith(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                          MessageDataText(
                            mainText: "Current Balance",
                            subText: "${homeConsumer.userBalance} LYD",
                            color: whiteColor,
                          ),
                        ],
                ),

                Expanded(
                  child: homeConsumer.busy
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : homeConsumer.noData
                      ? const Center(child: Text("No transactions yet"))
                      : ListView.builder(
                          itemCount: homeConsumer.homeScreen.length,
                          itemBuilder: (context, index) {
                            final transfer = homeConsumer.homeScreen[index];
                            return TransactionTile(
                              amount: transfer.amount,
                              date: transfer.date,
                              type: transfer.transactionType,
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
