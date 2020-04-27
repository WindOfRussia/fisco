import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logger_service.dart';

/// Permanent storage implementation via shared preferences plugin
class Storage {

  /// Retrieve objects from storage and deserialize
  /// warning: objects and nested attributes need to implement fromJson
  static Future<List> retrieve(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Logger.log("retrieving $key from storage...");
    var json = prefs.getString(key);
    if (json != null) {
      return jsonDecode(json);
    }
    return [];
  }

  /// Serializes objects into json
  /// warning: object have to implement toJson, nested objects need to
  ///          support json as well
  static Future<bool> store(String key, Object obj) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Logger.log("adding $key to storage...", object: obj);
    return prefs.setString(key, jsonEncode(obj));
  }

  static Future<Directory> getTemp() async {
    return await getTemporaryDirectory();
  }

}