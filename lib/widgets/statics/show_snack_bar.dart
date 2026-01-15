import 'package:flutter/material.dart';

class ShowSnackBar extends StatelessWidget {
  final String message;
  final bool isError;
  const ShowSnackBar({super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    // return ShowSnackBar(
    //   message: message,
    //   isError: isError,
    // );

    return SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }
}
