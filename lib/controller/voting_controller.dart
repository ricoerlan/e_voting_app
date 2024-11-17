import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingController extends GetxController {
  final _repository = Repository();

  // Candidate List
  List<CandidateModel> candidates = [];
  CandidateModel? selectedCandidate;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    initializeData(); // Call the method to initialize data
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
      // Set loading to false once data is ready
      isLoading = false;
      update(); // Notify listeners (UI) to rebuild
    }
  }

  // Select a candidate
  void selectCandidate(CandidateModel candidate) {
    selectedCandidate = candidate;
    update(); // Updates the UI with the selected candidate
  }

  // Cast Vote
  void castVote() {
    if (selectedCandidate != null) {
      // Simulate voting success
      Get.dialog(
        AlertDialog(
          title: const Text('Vote Cast Successfully'),
          content: Text(
            'You have successfully voted for ${selectedCandidate!.name}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Show error message
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a candidate before voting.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
