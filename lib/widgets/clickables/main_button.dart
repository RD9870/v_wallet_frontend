import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class MainButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final Function onTap;
  final bool isBusy;



  const MainButton({super.key, required this.backgroundColor, required this.label, this.textColor = whiteColor, required this.onTap, this.isBusy = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ElevatedButton(
           onPressed: () {
          if (isBusy) {
            return;
          }
          onTap();
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), 
          padding: EdgeInsets.all(16),
          elevation: 10.0, 
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: 
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: isBusy ? CircularProgressIndicator(color: textColor,) : Text(label, style: labelMedium,),
        ),
      ),
    );
  }
}