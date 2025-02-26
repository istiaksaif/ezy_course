import 'package:get_storage/get_storage.dart';

const kIsLOGIN = "is_login";
const kUserInfo = 'user_info';
const kUserName = 'user_name';
const kUserType = 'user_type';
const kPhone = 'phone';
const kIsFirstTime = 'firstTime';
const kIsRated = 'app_rated';
const kLanguage = 'language';
const kFromBottom = 'kFromBottom';
const kBaseUrl = 'kBaseUrl';
const printer = 'printer';
const kPaperSize = 'paper_size';

class SessionManager {
  static GetStorage _preferences = GetStorage();

  static Future init() async => _preferences = GetStorage();

  // static dynamic setUser(User value) {
  //   _preferences.write(kUserInfo, value.toJson());
  // }
  //
  // static User? getUser() {
  //   Map<String, dynamic>? userMap = _preferences.read(kUserInfo);
  //   if (userMap != null) {
  //     return User.fromJson(userMap);
  //   }
  //   return null;
  // }

  static setValue(String key, dynamic value) {
    _preferences.write(key, value);
  }

  static dynamic getValue(String key) {
    return _preferences.read(key);
  }

  static dynamic removeValue(String key) {
    return _preferences.remove(key);
  }

  static dynamic logout() async {
    _preferences.remove(kIsLOGIN);
    _preferences.remove(kUserInfo);
    _preferences.remove(kUserName);
    _preferences.remove(kPhone);
    _preferences.remove(kBaseUrl);
    _preferences.remove(kUserType);
  }
}
