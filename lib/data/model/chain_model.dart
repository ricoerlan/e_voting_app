import 'dart:convert';

List<ChainModel> chainModelFromJson(List<dynamic> str) =>
    List<ChainModel>.from(str.map((x) => ChainModel.fromJson(x)));

String chainModelToJson(List<ChainModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChainModel {
  final int? index;
  final int? blockNumber;
  final DateTime? timestamp;
  final List<Transaction>? transactions;
  final String? previousHash;
  final int? nonce;
  final String? status;
  final String? hash;

  ChainModel({
    this.index,
    this.blockNumber,
    this.timestamp,
    this.transactions,
    this.previousHash,
    this.nonce,
    this.status,
    this.hash,
  });

  ChainModel copyWith({
    int? index,
    int? blockNumber,
    DateTime? timestamp,
    List<Transaction>? transactions,
    String? previousHash,
    int? nonce,
    String? status,
    String? hash,
  }) =>
      ChainModel(
        index: index ?? this.index,
        blockNumber: blockNumber ?? this.blockNumber,
        timestamp: timestamp ?? this.timestamp,
        transactions: transactions ?? this.transactions,
        previousHash: previousHash ?? this.previousHash,
        nonce: nonce ?? this.nonce,
        status: status ?? this.status,
        hash: hash ?? this.hash,
      );

  factory ChainModel.fromJson(Map<String, dynamic> json) => ChainModel(
        index: json["index"],
        blockNumber: json["block_number"],
        timestamp: json["timestamp"] != null
            ? DateTime.fromMillisecondsSinceEpoch((json["timestamp"] is int
                    ? json["timestamp"]
                    : (json["timestamp"] as double).toInt()) *
                1000)
            : null,
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
        previousHash: json["previous_hash"],
        nonce: json["nonce"],
        status: json["status"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "block_number": blockNumber,
        "timestamp": timestamp,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "previous_hash": previousHash,
        "nonce": nonce,
        "status": status,
        "hash": hash,
      };
}

class Transaction {
  final String? voter;
  final String? candidate;
  final String? signature;

  Transaction({
    this.voter,
    this.candidate,
    this.signature,
  });

  Transaction copyWith({
    String? voter,
    String? candidate,
    String? signature,
  }) =>
      Transaction(
        voter: voter ?? this.voter,
        candidate: candidate ?? this.candidate,
        signature: signature ?? this.signature,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        voter: json["voter"],
        candidate: json["candidate"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "voter": voter,
        "candidate": candidate,
        "signature": signature,
      };
}
