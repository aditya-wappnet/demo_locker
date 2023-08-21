import '../../helpers/validation.dart';
import '../api.dart';

class AuthRepository {
  final ApiClient? apiClient;
  final FormValidations? validation;
  AuthRepository({this.apiClient, this.validation});

  registerUser({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('user_register', jsonData: jsonData);
  }

  verifyEmail({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('verify_email', jsonData: jsonData);
  }

  resendOtp({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('resend_otp', jsonData: jsonData);
  }

  login({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('login', jsonData: jsonData);
  }

  forgotPassword({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('forgot_password', jsonData: jsonData);
  }

  otpVerification({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('verify_forgot_password_OTP', jsonData: jsonData);
  }

  resetPassword({required Map<String, dynamic> jsonData, dynamic param}) {
    return apiClient?.post('reset_password', jsonData: jsonData);
  }
}
