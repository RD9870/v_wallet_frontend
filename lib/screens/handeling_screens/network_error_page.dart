import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';
import 'package:v_wallet_frontend/widgets/statics/message_data_text.dart';

class NetworkErrorPage extends StatelessWidget {
  final VoidCallback onClick;
  const NetworkErrorPage({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/network_error.png"),
         
         Padding(padding: EdgeInsetsGeometry.all(12),
         child: 
         MessageDataText(mainText: "Something went wrong", subText: "please check your network connection and try again", isDisplay: true,)
         ),

         MainButton(backgroundColor: primaryColor, label: "Try Again", onTap: (){
          onClick();
         })
        ],
      ),
    );
  }
}