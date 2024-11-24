import 'package:e_voting/data/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:e_voting/data/model/chain_model.dart';

class HomeController extends GetxController {
  final _repository = Repository();
  List<ChainModel> transactions = [];
  Map<String, int> candidateVoteCount = {};
  bool isLoading = false;

  void initializeData() async {
    isLoading = true;
    update();
    try {
      final result = await _repository.getBlockChains();
      transactions = result;
      updateVoteCounts();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      update();
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
    update();
  }
}
