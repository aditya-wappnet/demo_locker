import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../helpers/validation.dart';
import 'otp_verification_controller.dart';

class OtpVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OtpVerificationController(
        authRepo: AuthRepository(
          apiClient: ApiClient(),
          validation: FormValidations(),
        ),
      ),
    );
  }
}
