import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? mPrefencences;
  setString(String key, String value) async {
    mPrefencences = await SharedPreferences.getInstance();
    mPrefencences!.setString(key, value);
  }

  Future<String> getString(String key) async {
    mPrefencences = await SharedPreferences.getInstance();
    String data = mPrefencences!.getString(key) ?? '';
    return data;
  }

  Future<bool> removeStorage(String key) async {
    mPrefencences = await SharedPreferences.getInstance();
    mPrefencences!.remove(key);
    return true;
  }

  void setBool(String key, bool value) async {
    mPrefencences = await SharedPreferences.getInstance();
    mPrefencences!.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    mPrefencences = await SharedPreferences.getInstance();
    bool data = mPrefencences!.getBool(key) ?? false;
    return data;
  }
}
