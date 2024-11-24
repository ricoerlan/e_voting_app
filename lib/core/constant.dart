import 'package:flutter/material.dart';

const baseUrl = 'http://192.168.1.10:8000';
const loginUrl = '$baseUrl/login_voter';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

class ApiEndPoints {
  // Fetch List
  static const fetchChain = "/chain/";
  static const fetchCandidates = "/candidates/";

  // Voter
  static const registerVoter = "/register_voter/";
  static const loginVoter = "/login_voter/";
  static const castVote = "/vote/";

  // Committee
  static const loginCommittee = "/login_committee/";
  static const registerCandidate = "/register_candidate/";
}
