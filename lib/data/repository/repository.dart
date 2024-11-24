import 'package:dio/dio.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/data/api_service/api_service.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:e_voting/data/model/chain_model.dart';
import 'package:e_voting/data/model/profile_model.dart';
import 'package:flutter/foundation.dart';

class Repository {
  final ApiService _apiService = ApiService();

  // 1. Register Voter
  Future<ProfileModel> registerVoter(
      {required String nim, required String password}) async {
    try {
      final result = await _apiService.post(
        ApiEndPoints.registerVoter,
        data: FormData.fromMap(
          {"nim": nim, "password": password},
        ),
      );
      final data = result.data;
      if (data['status_code'] != 201) {
        throw data["detail"];
      }
      return ProfileModel.fromJson(data['data']);
    } catch (e) {
      rethrow;
    }
  }

  // 2. Login Voter && Committee
  Future<ProfileModel> login(
      {required String nim,
      required String password,
      bool isCommittee = false}) async {
    try {
      final result = await _apiService.post(
        isCommittee ? ApiEndPoints.loginCommittee : ApiEndPoints.loginVoter,
        data: FormData.fromMap(
          {isCommittee ? "username" : "nim": nim, "password": password},
        ),
      );
      final data = result.data;
      if (data['status_code'] != 200) {
        throw data["detail"];
      }
      return ProfileModel.fromJson(data['data']);
    } catch (e) {
      rethrow;
    }
  }

  // 3. Get chains
  Future<List<ChainModel>> getBlockChains() async {
    List<ChainModel> chains = [];
    try {
      final response = await _apiService.get(ApiEndPoints.fetchChain);
      final data = response.data;
      if (data['status_code'] == 200) {
        chains.addAll(chainModelFromJson(data['data']));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return chains;
  }

  // 4. Get Candidates
  Future<List<CandidateModel>> getCandidates() async {
    List<CandidateModel> candidates = [];
    try {
      final response = await _apiService.get(ApiEndPoints.fetchCandidates);
      final data = response.data;
      if (data['status_code'] == 200) {
        candidates.addAll(candidateModelFromJson(data['data']));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
    return candidates;
  }

  // 5. Register Candidate (committee only)
  Future<CandidateModel> registerCandidate(
      {required String nim, required String photo}) async {
    try {
      final result = await _apiService.post(ApiEndPoints.registerCandidate,
          data: FormData.fromMap(
            {"nim": nim, "photo": photo},
          ));
      return CandidateModel.fromJson(result.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  // 5. Cast Vote (Voter only)
  Future<bool> castVote(
      {required String voterNim, required String candidateNim}) async {
    try {
      final result = await _apiService.post(ApiEndPoints.castVote,
          data: FormData.fromMap(
            {"voter_nim": voterNim, "candidate_nim": candidateNim},
          ));
      final data = result.data;
      if (data['status_code'] != 201) {
        throw data["detail"];
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
