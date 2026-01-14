import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/providers/home_provider.dart';
import 'package:v_wallet_frontend/screens/main_screens/home_screen.dart';
import 'package:v_wallet_frontend/screens/main_screens/top_up_screen.dart';
import 'package:v_wallet_frontend/screens/main_screens/transfers_screen.dart';

class MainViewScreen extends StatefulWidget {
  const MainViewScreen({super.key});

  @override
  State<MainViewScreen> createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
    final pages = [TopUpScreen(), HomeScreen(), TranfersScreen()];
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, HomeProvider>(
      builder: (context, authConsumer, homeConsumer, _) {
        return Scaffold(
          body: IndexedStack(index: homeConsumer.index, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
            currentIndex: homeConsumer.index,
            onTap: (value) {
              homeConsumer.setIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                label: "Top-Up",
                icon: Icon(Icons.wallet),
              ),
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                label: "Transfer",
                icon: Icon(Icons.swap_horiz),
              ),
            ],
          ),
        );
      },
    );
  }
}
