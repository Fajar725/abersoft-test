import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/infra/enum/preferences_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CustomPreferences {

  Future<String?> _getLocalPreferences(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(key.toString());

      return data;
    } on Exception {
      throw const PreferncesException("Error");
    }
  }

  Future<bool> _setLocalPreferences(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(key.toString(), value);
    } on Exception {
      throw const PreferncesException("Error");
    }
  }

  Future<bool> _removeLocalPreferences(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.remove(key.toString());
    } on Exception {
      throw const PreferncesException("Error");
    }
}

}

class StringPreferences extends CustomPreferences{
  static StringPreferences? _stringPreferences;

  StringPreferences._();

  static StringPreferences instance(){
    _stringPreferences ??= StringPreferences._();

    return _stringPreferences!;
  }
  
  Future<String?> getPreferences(String key) {
    return _getLocalPreferences(key);
  }

  Future<bool> removePreferences(String key) {
    return _removeLocalPreferences(key);
  }

  Future<bool> setPreferences(String key, String value) {
    return _setLocalPreferences(key, value);
  }

}

class EnumPreferences extends CustomPreferences{
  static EnumPreferences? _enumPreferences;

  EnumPreferences._();

  static EnumPreferences instance(){
    _enumPreferences ??= EnumPreferences._();

    return _enumPreferences!;
  }

  Future<String?> getPreferences(PreferencesEnum key) {
    return _getLocalPreferences(key.toString());
  }

  Future<bool> removePreferences(PreferencesEnum key) {
    return _removeLocalPreferences(key.toString());
  }

  Future<bool> setPreferences(PreferencesEnum key, String value) {
    return _setLocalPreferences(key.toString(), value);
  }

}