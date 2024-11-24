import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/signup/signup_screen.dart';
import 'package:e_voting/view/widget/already_have_an_account_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

class LoginForm extends StatefulWidget {
  final String role;
  final int currentIndex;

  const LoginForm({super.key, required this.role, required this.currentIndex});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final authController = Get.find<AuthController>();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                    return widget.currentIndex == 0
                        ? "Username harus diisi"
                        : "NIM harus diisi";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  authController.nim = value;
                },
                decoration: InputDecoration(
                  hintText: widget.currentIndex == 0 ? "Username" : "NIM",
                  prefixIcon: const Icon(Icons.person),
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
                      return "Password harus diisi";
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
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () async {
                  final validated = _formKey.currentState!.validate();
                  if (!validated) {
                    return;
                  }
                  authController.login(widget.currentIndex == 0);
                },
                child: Text("Login".toUpperCase()),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
