import 'package:maket/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> set({
    DataType dataType,
    String key,
    dynamic value,
  }) async {
    SharedPreferences storage = await _instance();
    switch (dataType) {
      case DataType.string:
        return await storage.setString(key, value);
      case DataType.int:
        return await storage.setInt(key, value);
      case DataType.double:
        return storage.setDouble(key, value);
      case DataType.bool:
        return await storage.setBool(key, value);
      case DataType.stringList:
        return await storage.setStringList(key, value);
      default:
        return false;
    }
  }

  static Future<String> get(String key) async {
    SharedPreferences storage = await _instance();
    try {
      return storage.get(key);
    } catch (ex) {
      return null;
    }
  }

  static Future<bool> remove({String key}) async {
    SharedPreferences storage = await _instance();
    try {
      return storage.remove(key);
    } catch (ex) {
      return false;
    }
  }

  static Future<SharedPreferences> _instance() async {
    return await SharedPreferences.getInstance();
  }
}
