import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int selectedIndex =
      0; // Variabel untuk menyimpan indeks tab yang dipilih. Secara default, tab pertama (indeks 0) yang dipilih.

  // Fungsi untuk mengganti indeks tab yang dipilih
  void changeTabIndex(int index) {
    selectedIndex =
        index; // Mengubah nilai selectedIndex dengan indeks yang diberikan sebagai parameter.
    update(); // Memperbarui UI untuk refleksi perubahan status selectedIndex.
  }
}
