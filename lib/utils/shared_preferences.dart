import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  late SharedPreferences _pref;
 /*  Preferences() {
    init();
  } */

  Future<bool> resetSettings() async {
    return _pref.clear();
  }

  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    var value = _pref.get(key);
    if (value == null) {
      _saveToDisk(key, defaultVal);
      return defaultVal;
    } else if (value is List) {
      var val = _pref.getStringList(key);
      return val;
    }
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _pref.setString(key, content);
    }
    if (content is bool) {
      _pref.setBool(key, content);
    }
    if (content is int) {
      _pref.setInt(key, content);
    }
    if (content is double) {
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      _pref.setStringList(key, content);
    }
    if (content == null) {
      _pref.remove(key);
    }
  }

  String? get impactRefreshToken => _getFromDisk('impactRefreshToken');
  set impactRefreshToken(String? impactRefreshToken) => _saveToDisk("impactRefreshToken", impactRefreshToken);
  
  String? get impactAccessToken => _getFromDisk('impactAccessToken');
  set impactAccessToken(String? impactAccessToken) => _saveToDisk("impactAccessToken", impactAccessToken);

  String? get username => _getFromDisk('username');
  set username(String? username) => _saveToDisk("username", username);

  String? get password => _getFromDisk('password');
  set password(String? password) => _saveToDisk("password", password);

  String? get purpleAirXApiKey => _getFromDisk('purpleAirXApiKey');
  set purpleAirXApiKey(String? purpleAirXApiKey) => _saveToDisk("purpleAirXApiKey", purpleAirXApiKey);
}
