import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

typedef ParseFunction<T> = T Function(dynamic json);

class JsonUtil {
  static late final JsonUtil _instance = JsonUtil._internal();
  JsonUtil._internal();
  factory JsonUtil() => _instance;

  static Future<String> loadJsonFromAssets(String filePath) async {
    return rootBundle.loadString(filePath);
  }

  static Future<Map<String, dynamic>> loadAndDecodeJson(String filePath) async {
    String jsonString = await loadJsonFromAssets(filePath);
    return jsonDecode(jsonString);
  }

  static Future<T> loadAndDeserializeJson<T>(String filePath, ParseFunction<T> fromJsonT) async {
    final json = await loadAndDecodeJson(filePath);
    return fromJsonT(json);
  }
}
