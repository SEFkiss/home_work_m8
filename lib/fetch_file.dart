import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) {
  return rootBundle
      .loadString(assetsPath)
      .then((file) => file.toString())
      .catchError((e) => 'Err');
}

Future<String> fetchFileFromAssets1(String assetsPath) {
  return rootBundle
      .loadString(assetsPath)
      .then((file) => file.toString())
      .catchError((e) => 'Файл не найден!');
}
