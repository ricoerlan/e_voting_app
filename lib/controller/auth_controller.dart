import 'package:e_voting/data/model/profile_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:e_voting/data/repository/shared_pref_repository.dart';
import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController extends GetxController {
  final _repository = Repository();
  final _sharedPrefRepository = SharedPrefRepository();
  bool isLoading = false;
  String nim = "";
  String password = "";
  bool isCommittee = false;

  void login(bool value) async {
    isLoading = true;
    update();
    try {
      final data = await _repository.login(
          nim: nim, password: password, isCommittee: value);
      if (data.id != null) {
        await setCurrentProfile(data: data);
        isCommittee = data.isCommittee ?? false;
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'error',
        message: e.toString(),
      ));
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> setCurrentProfile({required ProfileModel data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('profile', json.encode(data.toJson()));

    if (result) {
      Get.offAll(() => const BottomNavScreen());
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: 'error',
        message: 'error saving profile data',
      ));
    }
  }

  // Save registration info and biometrics preference
  void register() async {
    isLoading = true;
    update();
    try {
      final data =
          await _repository.registerVoter(nim: nim, password: password);
      if (data.id != null) {
        await setCurrentProfile(data: data);
        isCommittee = data.isCommittee ?? false;
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'error',
        message: e.toString(),
      ));
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  // Log out and clear user data from SharedPreferences
  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored data
      isCommittee = false;
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: const Text(
            'Logged out successfully',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Failed'),
          content: const Text(
            'Logged out failed',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      update();
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<bool> checkIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('profile')) {
      return false;
    }
    final profile = await _sharedPrefRepository.getProfileData();
    isCommittee = profile.isCommittee ?? false;
    return true;
  }
}
