import 'package:flutter/cupertino.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class MessageDataText extends StatelessWidget {
  final String mainText;
  final String subText;
  final bool? isDisplay;
  final Color? color;

  const MessageDataText({super.key, required this.mainText, required this.subText, this.isDisplay, this.color});

  @override
  Widget build(BuildContext context) {
      // final mainStyle = isDisplay == true ? displayLarge : labelExtraLarge;
      TextAlign? aligment = isDisplay == true? TextAlign.center: null;
      TextStyle mainStyle = isDisplay == true ? displayLarge : labelExtraLarge;
      TextStyle subStyle = isDisplay == true ? displaySmall : labelLarge;

      if(color !=null){
        mainStyle = mainStyle.copyWith(color: color);
        subStyle = subStyle.copyWith(color: color);
      }

    return Column(
      children: 
      [
        Text(mainText, style:mainStyle, textAlign: aligment,),
        Text(subText, style: subStyle, textAlign: aligment)
      ],
    );
  }
}