import 'dart:io';

import 'package:e_voting/controller/candidate_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/data/model/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Layar utama untuk menampilkan daftar kandidat dan memungkinkan admin menambahkan kandidat baru.
class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  // Menyimpan referensi ke CandidateController yang menangani logika kandidat
  final CandidateController candidateController =
      Get.put(CandidateController());
  // Menyimpan referensi ke ImagePicker untuk memilih gambar kandidat
  final ImagePicker _imagePicker = ImagePicker();
  // Menyimpan controller untuk field input NIM
  final TextEditingController nimController = TextEditingController();
  // Variabel untuk menyimpan gambar yang dipilih
  XFile? image;

  @override
  Widget build(BuildContext context) {
    // RefreshIndicator memungkinkan layar ini untuk di-refresh dengan menariknya ke bawah
    return RefreshIndicator(
      onRefresh: () {
        // Memuat ulang data kandidat saat refresh
        candidateController.initializeData();
        return Future.value();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Candidate', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul untuk daftar kandidat
              const Text(
                'Candidate List',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(height: 20),
              // GetBuilder digunakan untuk mendengarkan pembaruan dari CandidateController
              GetBuilder<CandidateController>(
                init: CandidateController(),
                initState: (controller) => candidateController
                    .initializeData(), // Memuat data saat inisialisasi
                builder: (controller) {
                  if (controller.isLoading) {
                    // Menampilkan CircularProgressIndicator jika data masih dimuat
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        // Daftar kandidat ditampilkan dengan ListView
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.candidates.length,
                            itemBuilder: (context, index) {
                              final candidate = controller.candidates[index];
                              // Menampilkan card untuk setiap kandidat
                              return CandidateCard(candidate: candidate);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Tombol untuk menambahkan kandidat
                        _addCandidateButton(),
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

  // Fungsi untuk menampilkan dialog tambah kandidat
  void showAddCandidateDialog() {
    // Menampilkan dialog menggunakan Get.dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Add Candidate'),
        content: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input field untuk memasukkan NIM kandidat
              TextFormField(
                controller: nimController,
                textInputAction: TextInputAction.done,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIM harus diisi"; // Pesan error jika NIM kosong
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  candidateController.nim =
                      value; // Menyimpan nilai NIM ke controller
                },
                decoration: const InputDecoration(
                  hintText: "NIM",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Container untuk memilih foto kandidat
              GestureDetector(
                onTap: () async {
                  // Membuka galeri untuk memilih gambar kandidat
                  final pickedFile =
                      await _imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    image = pickedFile;
                  }
                  setState(() {}); // Memperbarui UI setelah gambar dipilih
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: image == null
                      ? const Center(
                          child: Icon(Icons.add_a_photo,
                              size:
                                  40)) // Menampilkan ikon jika belum ada gambar
                      : Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          );
        }),
        actions: [
          // Tombol Cancel untuk menutup dialog tanpa menambahkan kandidat
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          // Tombol Add Candidate untuk menambahkan kandidat
          TextButton(
            onPressed: () {
              if (nimController.text.isNotEmpty) {
                // Memanggil fungsi untuk menambahkan kandidat jika NIM tidak kosong
                candidateController.addCandidate(image);
                Get.back(); // Menutup dialog setelah menambahkan kandidat
              } else {
                // Menampilkan snackbar jika NIM kosong
                Get.snackbar('Error', 'Please enter a valid NIM');
              }
            },
            child: const Text('Add Candidate'),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol "Add Candidate"
  Widget _addCandidateButton() {
    return GestureDetector(
      onTap: () =>
          showAddCandidateDialog(), // Menampilkan dialog saat tombol ditekan
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
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_add_outlined,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Add Candidate',
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

// Widget untuk menampilkan informasi kandidat dalam bentuk card
class CandidateCard extends StatelessWidget {
  final CandidateModel candidate;

  const CandidateCard({
    super.key,
    required this.candidate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.blueAccent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menampilkan informasi nama dan fakultas kandidat
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  candidate.name ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  candidate.faculty ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 22),
                ),
              ],
            ),
            // Menampilkan foto kandidat jika ada
            if (candidate.photo != null)
              Image.network(
                '$baseUrl/${candidate.photo!}',
                height: 60,
                width: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person_outline,
                  size: 60,
                ),
              )
          ],
        ),
      ),
    );
  }
}
