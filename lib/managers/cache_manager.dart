import 'package:get_storage/get_storage.dart';

import '../common/pages/login/model/login_model.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

  Future<bool> saveFCMToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.FCMTOKEN.toString(), token);
    return true;
  }

  String? getFCMToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.FCMTOKEN.toString());
  }

  Future<void> removeFCMToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.FCMTOKEN.toString());
  }

  bool? getBoardStatus() {
    final box = GetStorage();
    return box.read(CacheManagerKey.BOARDSTATUS.toString());
  }

  Future<bool> saveBoardStatus(bool? status) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.BOARDSTATUS.toString(), status);
    return true;
  }

  Future<bool> saveUser(LoginData? userData) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.USER.toString(), userData!.toJson());
    return true;
  }

  Map<String, dynamic>? getUserData() {
    final box = GetStorage();
    return box.read(CacheManagerKey.USER.toString());
  }

  Future<void> removeUser() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.USER.toString());
  }
}

enum CacheManagerKey {
  TOKEN,
  BOARDSTATUS,
  FCMTOKEN,
  USER,
  OVERLAYSTATUS,
}
