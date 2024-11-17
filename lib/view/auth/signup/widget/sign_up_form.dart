import 'package:dio/dio.dart';
import 'package:e_voting/data/api_service/api_service.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
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
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

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
            // onSaved: (nim) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'NIM harus diisi';
              }
              return null;
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
              try {
                final result = await _apiService.post('/register_voter/',
                    data: FormData.fromMap(
                      {
                        "nim": nimController.text,
                        "password": passwordController.text
                      },
                    ));
                if (result.statusCode == 200) {
                  Get.to(() => BottomNavScreen());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result.data['detail'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
