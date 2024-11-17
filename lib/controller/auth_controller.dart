import 'package:e_voting/data/model/voter_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:e_voting/view/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final _repository = Repository();
  bool isLoading = false;
  String nim = "";
  String password = "";
  // bool isCommittee = false;

  void login(bool isCommittee) async {
    isLoading = true;
    update();
    try {
      final data = await _repository.login(
          nim: nim, password: password, isCommittee: isCommittee);
      if (data.id != null) {
        await setCurrentProfile(data: data);
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

  Future<void> setCurrentProfile({required VoterModel data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('profile', json.encode(data.toJson()));

    if (result) {
      final profile = voterModelFromJson(prefs.getString('profile')!);
      print("profile");
      print(profile.toJson());
      Get.to(HomeScreen());
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'error',
        message: 'detail',
      ));
    }
  }

  // Save registration info and biometrics preference
  Future<bool> register({
    required String nim,
    required String password,
    required bool biometricsEnabled,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {
      'nim': nim,
      'password': password,
      'biometricsEnabled': biometricsEnabled,
    };
    await prefs.setString(nim, jsonEncode(user));
    return true;
  }

  // Log out and clear user data from SharedPreferences
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
  }

  // Save biometrics preference during registration
  Future<void> saveBiometricsPreference({
    required String nim,
    required bool biometricsEnabled,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(nim);
    if (userData != null) {
      Map<String, dynamic> user = jsonDecode(userData);
      user['biometricsEnabled'] = biometricsEnabled;
      await prefs.setString(nim, jsonEncode(user));
    }
  }
}
