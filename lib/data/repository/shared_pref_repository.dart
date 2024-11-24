import 'package:e_voting/data/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  // Get Profile Data
  Future<ProfileModel> getProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final result = profileModelFromJson(prefs.getString('profile') ?? '');
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
