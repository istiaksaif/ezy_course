import 'package:get_storage/get_storage.dart';

const kIsLOGIN = "is_login";
const kToken = 'user_token';
const kEmail = 'email';
const kPassword = 'password';
const kRemember = 'remember';

class SessionManager {
  static GetStorage _preferences = GetStorage();

  static Future init() async => _preferences = GetStorage();

  static setValue(String key, dynamic value) {
    _preferences.write(key, value);
  }

  static dynamic getValue(String key, {dynamic value}) {
    return _preferences.read(key) ?? value;
  }

  static dynamic removeValue(String key) {
    return _preferences.remove(key);
  }

  static dynamic logout() async {
    final email = getValue(kEmail);
    final password = getValue(kPassword);
    final remember = getValue(kRemember);

    await _preferences.erase();

    setValue(kEmail, email);
    setValue(kPassword, password);
    setValue(kRemember, remember);
  }
}
