import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingController extends GetxController {
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

  // Select a candidate
  void selectCandidate(CandidateModel candidate) {
    selectedCandidate = candidate;
    update();
  }

  // Cast Vote
  void castVote() async {
    if (selectedCandidate != null) {
      isLoading = true;
      update();
      try {
        final result =
            await _repository.castVote(voterNim: '1', candidateNim: '1');
        if (!result) {
          throw 'Something is wrong, please try again';
        }
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
      } catch (e) {
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        isLoading = false;
        update();
      }
    } else {
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
