import 'package:e_voting/data/model/profile_model.dart';
import 'package:e_voting/data/repository/shared_pref_repository.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _repository = SharedPrefRepository();
  bool isLoading = false;
  ProfileModel profileModel = ProfileModel();

  void initializeData() async {
    isLoading = true;
    update();
    try {
      final result = await _repository.getProfileData();
      profileModel = result;
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
