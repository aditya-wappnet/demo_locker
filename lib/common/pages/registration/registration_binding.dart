import 'package:demo_locker_app/common/pages/registration/registration_controller.dart';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/validation.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegistrationController(
        authRepo: AuthRepository(
          apiClient: ApiClient(),
          validation: FormValidations(),
        ),
      ),
    );
  }
}
