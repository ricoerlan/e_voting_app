import 'package:dio/dio.dart';
import 'package:e_voting/controller/auth_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/data/api_service/api_service.dart';
import 'package:e_voting/view/auth/signup/signup_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:e_voting/view/widget/already_have_an_account_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;

class LoginForm extends StatefulWidget {
  final String role; // Role passed from the parent widget

  const LoginForm({super.key, required this.role});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final authController = Get.put(AuthController());
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

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
                    authController.nim = value;
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
                  authController.login(widget.role == 'committee');

                  // try {
                  //   String loginEndpoint = widget.role == 'committee'
                  //       ? '/login_committee/'
                  //       : '/login_voter/'; // Different API endpoints based on role

                  //   final result = await _apiService.post(
                  //     loginEndpoint,
                  //     data: FormData.fromMap(
                  //       {
                  //         "nim": nimController.text,
                  //         "password": passwordController.text
                  //       },
                  //     ),
                  //   );

                  //   if (result.statusCode == 200) {
                  //     Get.to(() => BottomNavScreen());
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text(
                  //           result.data['detail'].toString(),
                  //           style: const TextStyle(color: Colors.white),
                  //         ),
                  //         backgroundColor: Colors.red,
                  //       ),
                  //     );
                  //   }
                  // } catch (e) {
                  //   if (kDebugMode) {
                  //     print(e);
                  //   }
                  // }
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
