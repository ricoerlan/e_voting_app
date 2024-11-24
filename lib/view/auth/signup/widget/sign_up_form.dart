import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/widget/already_have_an_account_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  _SignUpFormState();
  final authController = Get.find<AuthController>();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nimController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'NIM harus diisi';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isEmpty) {
                return;
              }
              authController.nim = value;
            },
            decoration: const InputDecoration(
              hintText: "NIM",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password harus diisi';
                }
                return null;
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                authController.password = value;
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              final validated = _formKey.currentState!.validate();
              if (!validated) {
                return;
              }
              authController.register();
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
