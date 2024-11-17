import 'package:e_voting/controller/voting_controller.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingScreen extends StatelessWidget {
  VotingScreen({super.key});

  // Controller instance using GetX
  final VotingController votingController = Get.put(VotingController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        votingController.initializeData();
        return Future.value();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Voting',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a candidate to vote for:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              // Candidate List
              GetBuilder<VotingController>(
                init: VotingController(),
                builder: (controller) {
                  // Handle loading state if candidates are still being fetched
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.candidates.length,
                            itemBuilder: (context, index) {
                              final candidate = controller.candidates[index];
                              return CandidateCard(
                                candidate: candidate,
                                isSelected:
                                    controller.selectedCandidate == candidate,
                                onTap: () {
                                  controller.selectCandidate(candidate);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Vote Button
                        _voteButton(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Vote Button Widget
  Widget _voteButton() {
    return GestureDetector(
      onTap: () => votingController.castVote(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Cast Vote',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CandidateCard extends StatelessWidget {
  final CandidateModel candidate;
  final bool isSelected;
  final VoidCallback onTap;

  const CandidateCard({
    super.key,
    required this.candidate,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? Colors.blueAccent : Colors.grey,
                size: 30,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candidate.name ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blueAccent : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    candidate.faculty ?? '',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
