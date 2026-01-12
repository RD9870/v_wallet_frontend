import 'package:flutter/cupertino.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class MessageDataText extends StatelessWidget {
  final String mainText;
  final String subText;
  final bool? isDisplay;

  const MessageDataText({super.key, required this.mainText, required this.subText, this.isDisplay});

  @override
  Widget build(BuildContext context) {
      final mainStyle = isDisplay == true ? displayLarge : extraLargeLabel;
      final aligment = isDisplay == true? TextAlign.center: null;
  final subStyle = isDisplay == true ? displaySmall : labelLarge;
    return Column(
      children: 
      [
        Text(mainText, style:mainStyle, textAlign: aligment,),
        Text(subText, style: subStyle, textAlign: aligment)
      ],
    );
  }
}