import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:e_voting/data/model/chain_model.dart';

class HomeController extends GetxController {
  final _repository = Repository();
  // List of transactions (this can be fetched from an API or database)
  List<ChainModel> transactions = [];

  // A map to keep track of the vote count for each candidate
  Map<String, int> candidateVoteCount = {};

  // Loading state (without Rx)
  bool isLoading = false;

  // Initialize data
  @override
  void onInit() {
    super.onInit();
    initializeData(); // Call the method to initialize data
  }

  void initializeData() async {
    isLoading = true;
    update();
    try {
      final result = await _repository.getBlockChains();
      transactions = result;
      updateVoteCounts(); // Update the vote counts based on the transactions
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

  // Update the vote counts based on the transactions
  void updateVoteCounts() {
    candidateVoteCount.clear();

    for (var tx in transactions) {
      if (tx.status?.toUpperCase() == 'CONFIRMED') {
        for (var transaction in tx.transactions ?? []) {
          final candidate = transaction.candidate ?? '';
          if (candidate.isNotEmpty) {
            candidateVoteCount[candidate] =
                (candidateVoteCount[candidate] ?? 0) + 1;
          }
        }
      }
    }
    update(); // Notify listeners (UI) to rebuild
  }
}
