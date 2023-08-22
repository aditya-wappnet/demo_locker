import 'package:demo_locker_app/pages/home_page/home_page_binding.dart';
import 'package:get/get.dart';

import '../common/pages/forgot_password/forgot_password_binding.dart';
import '../common/pages/forgot_password/forgot_password_page.dart';
import '../common/pages/login/login_binding.dart';
import '../common/pages/login/login_page.dart';
import '../common/pages/otp_verification/otp_verification.dart';
import '../common/pages/otp_verification/otp_verification_binding.dart';
import '../common/pages/registration/registration_binding.dart';
import '../common/pages/registration/registration_page.dart';
import '../common/pages/reset_password/reset_password_binding.dart';
import '../common/pages/reset_password/reset_password_page.dart';
import '../pages/home_page/home_page.dart';
import '../splashscreen.dart';
import 'app_route.dart';

final routePages = [
  GetPage(
    name: ROUTE_ROOT,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: ROUTE_LOGIN,
    binding: LoginBinding(),
    page: () => const LoginPage(),
  ),
  GetPage(
      name: ROUTE_REGISTATION,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_FORGOTPASSWORD,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_OTP_VERIFICATION,
      page: () => const OtpVerificationPage(),
      binding: OtpVerificationBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_RESET_PASSWORD,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft),
];
