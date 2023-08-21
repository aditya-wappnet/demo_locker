import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/textStyle.dart';
import 'enum.dart';

getSnackBar(String message, SNACK type, {String? title, Duration? duration}) {
  return Get.snackbar(
    title ?? '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == SNACK.SUCCESS ? Colors.green : Colors.red,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 10,
    colorText: Colors.white,
    titleText: Container(
      height: 0,
    ),
    messageText: Text(
      message,
      style: textRegularStyle.copyWith(
          fontWeight: FontWeight.normal, color: Colors.white),
    ),
    padding: const EdgeInsets.only(left: 20, top: 10, bottom: 18, right: 10),
    margin: const EdgeInsets.all(15),
    duration: duration ?? const Duration(seconds: 3),
  );
}

void saveData(String key, dynamic value) {
  final box = GetStorage();
  box.write(key, value);
}

dynamic getData(String key) {
  final box = GetStorage();
  return box.read(key);
}

void removeData(String key) {
  final box = GetStorage();
  box.remove(key);
}
