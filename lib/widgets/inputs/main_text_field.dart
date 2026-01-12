import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.hidePassword,
    this.iconTap,
  });
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? hidePassword;
  final VoidCallback? iconTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(children: [Text(label, style: labelSmall)]),
            ),
          TextFormField(
            obscureText: hidePassword != null ? hidePassword! :false,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              suffixIcon: suffixIcon != null ? suffixIcon! : IconButton(onPressed: iconTap, icon: hidePassword == true? Icon(Icons.remove_red_eye_outlined): hidePassword == false? Icon(Icons.visibility_off) : SizedBox()),
              
              // prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: grayColor),
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: redColor),

                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
