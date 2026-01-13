import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:v_wallet_frontend/helpers/consts.dart';
import 'package:v_wallet_frontend/helpers/functions_helper.dart';
import 'package:v_wallet_frontend/providers/auth_provider.dart';
import 'package:v_wallet_frontend/screens/auth_screens/register_screen.dart';
import 'package:v_wallet_frontend/screens/main_screens/home_screen.dart';
import 'package:v_wallet_frontend/widgets/clickables/main_button.dart';
import 'package:v_wallet_frontend/widgets/inputs/main_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: authConsumer.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: getSize(context).height * 0.3,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/v_wallet_logo.png",
                                        height: getSize(context).width * 0.3,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "V-Wallet",
                                            style: labelExtraLarge.copyWith(
                                              color: whiteColor,
                                            ),
                                          ),
                                          Text(
                                            "Instant payment made easier",
                                            style: labelSmall.copyWith(
                                              color: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: getSize(context).width * 0.5,
                                    child: Text(
                                      "Log in to your account",
                                      style: labelExtraLarge.copyWith(
                                        color: whiteColor,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MainTextField(
                            prefixIcon: Icon(Icons.phone),
                            label: "Phone Number",
                            controller: authConsumer.phoneController,
                            validator: authConsumer.validatePhone,
                          ),
                          MainTextField(
                            prefixIcon: Icon(Icons.lock),
                            label: "Password",
                            controller: authConsumer.passwordController,
                            validator: authConsumer.validatePassword,
                            hidePassword: authConsumer.hidePassword,
                            iconTap: authConsumer.setHidePassword,
                          ),
                          MainButton(
                            isBusy: authConsumer.busy,
                            backgroundColor: primaryColor,
                            label: "Login",
                            onTap: () async {
                              if (authConsumer.formKey.currentState!
                                  .validate()) {
                                final response = await authConsumer.login({
                                  "phone": authConsumer.phoneController.text,
                                  "password":
                                      authConsumer.passwordController.text,
                                });
                                if (context.mounted) {
                                  toastification.show(
                                    type: response.first
                                        ? ToastificationType.success
                                        : ToastificationType.error,
                                    title: Text(
                                      response.first ? "Success" : "Error",
                                    ),
                                    description: Text(response.last),
                                    autoCloseDuration: const Duration(
                                      seconds: 5,
                                    ),
                                  );
                                }
                                if (response.first && context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text("don't have an account? register"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
