import 'dart:convert';

// Fungsi untuk mengonversi List<dynamic> (data JSON) menjadi List<ChainModel>
// Menggunakan metode .map() untuk mengonversi setiap elemen dalam list menjadi objek ChainModel.
List<ChainModel> chainModelFromJson(List<dynamic> str) =>
    List<ChainModel>.from(str.map((x) => ChainModel.fromJson(x)));

// Fungsi untuk mengonversi List<ChainModel> menjadi string JSON.
// Menggunakan .map() untuk mengonversi setiap objek ChainModel menjadi Map, kemudian mengubahnya menjadi JSON.
String chainModelToJson(List<ChainModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Kelas ChainModel untuk merepresentasikan sebuah blok dalam blockchain, yang berisi informasi tentang transaksi dan metadata lainnya.
class ChainModel {
  final int? index; // Indeks blok dalam rantai blockchain (nullable)
  final int? blockNumber; // Nomor blok dalam blockchain (nullable)
  final DateTime? timestamp; // Waktu saat blok ditambahkan (nullable)
  final List<Transaction>?
      transactions; // Daftar transaksi dalam blok (nullable)
  final String? previousHash; // Hash dari blok sebelumnya (nullable)
  final int? nonce; // Nilai nonce untuk proses mining (nullable)
  final String? status; // Status dari blok (nullable)
  final String? hash; // Hash unik dari blok (nullable)

  // Konstruktor untuk membuat objek ChainModel dengan parameter opsional (nullable).
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

  // Metode copyWith untuk membuat salinan objek dengan perubahan properti tertentu.
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
        index: index ??
            this.index, // Jika parameter index tidak diberikan, gunakan nilai yang ada.
        blockNumber: blockNumber ??
            this.blockNumber, // Jika parameter blockNumber tidak diberikan, gunakan nilai yang ada.
        timestamp: timestamp ??
            this.timestamp, // Jika parameter timestamp tidak diberikan, gunakan nilai yang ada.
        transactions: transactions ??
            this.transactions, // Jika parameter transactions tidak diberikan, gunakan nilai yang ada.
        previousHash: previousHash ??
            this.previousHash, // Jika parameter previousHash tidak diberikan, gunakan nilai yang ada.
        nonce: nonce ??
            this.nonce, // Jika parameter nonce tidak diberikan, gunakan nilai yang ada.
        status: status ??
            this.status, // Jika parameter status tidak diberikan, gunakan nilai yang ada.
        hash: hash ??
            this.hash, // Jika parameter hash tidak diberikan, gunakan nilai yang ada.
      );

  // Factory constructor untuk membuat objek ChainModel dari Map JSON.
  // Map JSON ini biasanya diterima dari API atau sumber data lainnya.
  factory ChainModel.fromJson(Map<String, dynamic> json) => ChainModel(
        index: json["index"], // Mengambil nilai "index" dari JSON
        blockNumber:
            json["block_number"], // Mengambil nilai "block_number" dari JSON
        timestamp: json["timestamp"] != null
            ? DateTime.fromMillisecondsSinceEpoch((json["timestamp"] is int
                    ? json["timestamp"]
                    : (json["timestamp"] as double).toInt()) *
                1000) // Mengonversi timestamp Unix (detik) menjadi DateTime
            : null,
        transactions: json["transactions"] == null
            ? [] // Jika tidak ada transaksi, maka setel ke list kosong
            : List<Transaction>.from(json["transactions"]!.map((x) =>
                Transaction.fromJson(
                    x))), // Mengonversi transaksi menjadi list Transaction
        previousHash:
            json["previous_hash"], // Mengambil nilai "previous_hash" dari JSON
        nonce: json["nonce"], // Mengambil nilai "nonce" dari JSON
        status: json["status"], // Mengambil nilai "status" dari JSON
        hash: json["hash"], // Mengambil nilai "hash" dari JSON
      );

  // Metode toJson untuk mengonversi objek ChainModel ke dalam Map JSON.
  // Map ini nantinya dapat digunakan untuk dikirim ke server atau disimpan dalam format JSON.
  Map<String, dynamic> toJson() => {
        "index": index, // Mengonversi nilai "index" ke Map
        "block_number": blockNumber, // Mengonversi nilai "block_number" ke Map
        "timestamp": timestamp, // Mengonversi nilai "timestamp" ke Map
        "transactions": transactions == null
            ? [] // Jika tidak ada transaksi, setel ke list kosong
            : List<dynamic>.from(transactions!.map(
                (x) => x.toJson())), // Mengonversi transaksi menjadi list Map
        "previous_hash":
            previousHash, // Mengonversi nilai "previous_hash" ke Map
        "nonce": nonce, // Mengonversi nilai "nonce" ke Map
        "status": status, // Mengonversi nilai "status" ke Map
        "hash": hash, // Mengonversi nilai "hash" ke Map
      };
}

// Kelas Transaction untuk merepresentasikan transaksi yang ada dalam blok.
// Setiap transaksi mencatat pemilih, kandidat yang dipilih, dan tanda tangan transaksi.
class Transaction {
  final String? voter; // Voter yang melakukan transaksi (nullable)
  final String? candidate; // Kandidat yang dipilih (nullable)
  final String? signature; // Tanda tangan transaksi (nullable)

  // Konstruktor untuk membuat objek Transaction dengan parameter opsional (nullable).
  Transaction({
    this.voter,
    this.candidate,
    this.signature,
  });

  // Metode copyWith untuk membuat salinan objek dengan perubahan properti tertentu.
  Transaction copyWith({
    String? voter,
    String? candidate,
    String? signature,
  }) =>
      Transaction(
        voter: voter ??
            this.voter, // Jika parameter voter tidak diberikan, gunakan nilai yang ada.
        candidate: candidate ??
            this.candidate, // Jika parameter candidate tidak diberikan, gunakan nilai yang ada.
        signature: signature ??
            this.signature, // Jika parameter signature tidak diberikan, gunakan nilai yang ada.
      );

  // Factory constructor untuk membuat objek Transaction dari Map JSON.
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        voter: json["voter"], // Mengambil nilai "voter" dari JSON
        candidate: json["candidate"], // Mengambil nilai "candidate" dari JSON
        signature: json["signature"], // Mengambil nilai "signature" dari JSON
      );

  // Metode toJson untuk mengonversi objek Transaction ke dalam Map JSON.
  Map<String, dynamic> toJson() => {
        "voter": voter, // Mengonversi nilai "voter" ke Map
        "candidate": candidate, // Mengonversi nilai "candidate" ke Map
        "signature": signature, // Mengonversi nilai "signature" ke Map
      };
}
