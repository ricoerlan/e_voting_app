import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void dispose() {
    nimController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nimController,
              decoration: const InputDecoration(labelText: 'Enter your NIM'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: 'Enter your Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // bool isRegistered = await _authController.register(
                //   nim: nimController.text,
                //   password: passwordController.text,
                //   biometricsEnabled: biometricsEnabled,
                // );
                // if (isRegistered) {
                //   Get.snackbar('Success', 'Registration successful!');

                // // Prompt to enable biometrics after successful registration
                // await _enableBiometrics();

                // // Save the biometrics preference after enabling
                // _authController.saveBiometricsPreference(
                //   nim: nimController.text,
                //   biometricsEnabled: biometricsEnabled,
                // );

                //   Get.offAll(() => const LoginScreen());
                // } else {
                //   Get.snackbar('Error', 'Registration failed. Try again.');
                // }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
