import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({super.key, required this.kids});

  final List<Widget> kids;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: kids),
      ),
    );
  }
}
