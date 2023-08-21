import 'package:get/get.dart';

import '../common/pages/login/model/login_model.dart';
import '../data/api.dart';
import '../routes/app_route.dart';
import 'cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  final isFirstTime = false.obs;
  final userData = LoginData().obs;
  var profilePicPath = ''.obs;

  void setUser(LoginData data) async {
    userData.value = data;
    await saveUser(data);
  }

  void logOut() {
    isLogged.value = false;
    removeToken();
    removeUser();
    ApiClient().removeBaseToken();
    Get.offAllNamed(ROUTE_LOGIN);
  }

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  void sendToken(String? token) async {
    await saveFCMToken(token);
  }

  checkLoginStatus() {
    final token = getToken();

    if (token != null) {
      isLogged.value = true;
      Map<String, dynamic>? userMap = getUserData();
      LoginData user = LoginData.fromJson(userMap!);
      userData.value = user;
      ApiClient().setBaseToken(getToken());
    }
  }

  void checkBoardingStatus() {
    final status = getBoardStatus();
    if (status != null) {
      isFirstTime.value = status;
    }
  }

  void setBoardStatus(bool status) async {
    await saveBoardStatus(status);
  }

  dynamic navigation() async {
    AuthenticationManager authManager = Get.find();

    if (authManager.isLogged.value) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(ROUTE_HOME);
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(ROUTE_LOGIN);
      });
    }
  }
}
