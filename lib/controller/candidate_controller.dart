import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CandidateController extends GetxController {
  final _repository = Repository();
  List<CandidateModel> candidates = [];
  CandidateModel? selectedCandidate;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  void initializeData() async {
    isLoading = true;
    update();
    try {
      final result = await _repository.getCandidates();
      candidates = result;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void addCandidate() {}
}
