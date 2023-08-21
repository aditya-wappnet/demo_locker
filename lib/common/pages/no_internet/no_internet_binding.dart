import 'package:get/get.dart';

import 'no_internet_controller.dart';

class NoInternetBinding implements Bindings {
  static void init() async {
    Get.put<NoInternetController>(NoInternetController(), permanent: true);
  }

  @override
  void dependencies() {
    Get.lazyPut(() => NoInternetController());
  }
}
