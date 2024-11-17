import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../controller/auth_controller.dart';
import 'auth/login/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  bool biometricsEnabled = false;

  // Prompt the user to enable biometric authentication after registration
  Future<void> _enableBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to enable biometrics',
      );
      if (didAuthenticate) {
        setState(() {
          biometricsEnabled = true;
        });
        Get.snackbar(
            'Biometrics Enabled', 'You can now use biometrics for login.');
      }
    }
  }

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
                bool isRegistered = await _authController.register(
                  nim: nimController.text,
                  password: passwordController.text,
                  biometricsEnabled: biometricsEnabled,
                );
                if (isRegistered) {
                  Get.snackbar('Success', 'Registration successful!');

                  // Prompt to enable biometrics after successful registration
                  await _enableBiometrics();

                  // Save the biometrics preference after enabling
                  _authController.saveBiometricsPreference(
                    nim: nimController.text,
                    biometricsEnabled: biometricsEnabled,
                  );

                  Get.offAll(() => const LoginScreen());
                } else {
                  Get.snackbar('Error', 'Registration failed. Try again.');
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
