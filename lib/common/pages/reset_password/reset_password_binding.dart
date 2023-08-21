import 'package:demo_locker_app/common/pages/reset_password/reset_password_controller.dart';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/validation.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ResetPasswordController(
        authRepo: AuthRepository(
          apiClient: ApiClient(),
          validation: FormValidations(),
        ),
      ),
    );
  }
}
