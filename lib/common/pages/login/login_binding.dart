import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/validation.dart';
import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(
        authRepo: AuthRepository(
          apiClient: ApiClient(),
          validation: FormValidations(),
        ),
      ),
    );
  }
}
