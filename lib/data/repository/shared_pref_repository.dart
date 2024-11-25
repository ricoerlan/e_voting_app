import 'package:e_voting/data/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  // Fungsi untuk mengambil data profil dari SharedPreferences.
  Future<ProfileModel> getProfileData() async {
    try {
      final prefs = await SharedPreferences
          .getInstance(); // Mendapatkan instance SharedPreferences.
      // Mengambil data profil yang disimpan dalam SharedPreferences, jika tidak ada, akan mengembalikan string kosong.
      final result = profileModelFromJson(prefs.getString('profile') ?? '');
      return result; // Mengembalikan objek ProfileModel yang diambil dari SharedPreferences.
    } catch (e) {
      rethrow; // Jika terjadi error, error tersebut akan diteruskan.
    }
  }
}
