import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/validation.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgotPasswordController(
        authRepo: AuthRepository(
          apiClient: ApiClient(),
          validation: FormValidations(),
        ),
      ),
    );
  }
}
