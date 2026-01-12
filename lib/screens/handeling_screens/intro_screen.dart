import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/screens/auth_screens/login_screen.dart';
import 'package:v_wallet_frontend/screens/auth_screens/register_screen.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Welcome", style: TextStyle(
              fontSize: 40
            )),
              Image.asset("assets/v_wallet_logo.png"),
              SizedBox(height: 45),
            Text("V-Wallet", style: TextStyle(
              fontSize: 30
            ),),
            Text("Instant payment made easier", style: TextStyle(
              fontSize: 20
            ),),
            
                      SizedBox(height: 45),
            MainButton(
              backgroundColor: primaryColor,
              label: "Login",
              onTap: (){
                Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),

            MainButton(
              backgroundColor: secondaryColor,
              label: "Register",
              onTap: (){
                Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context) => RegisterScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}