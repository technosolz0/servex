import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';

class AuthApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  // 🔒 Registration OTP — POST /users/register-otp
  Future<Response> sendRegistrationOtp({
    required String name,
    required String email,
    required String mobile,
  }) async {
    return await _dio.post(
      'users/register-otp',
      data: {'name': name, 'email': email, 'mobile': mobile},
    );
  }

  // 🔒 Verify Registration OTP — POST /users/verify-otp
  Future<Response> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    return await _dio.post(
      'users/verify-otp',
      data: {'email': email, 'otp': otp},
    );
  }

  // 🔒 Resend Registration OTP — POST /users/resend-otp
  Future<Response> resendRegistrationOtp(String email) async {
    return await _dio.post('users/resend-otp', data: {'email': email});
  }

  // ✅ Login OTP — POST /user-auth/send-login-otp
  Future<Response> sendLoginOtp(String email) async {
    return await _dio.post('users/send-login-otp', data: {'email': email});
  }

  // ✅ Verify Login OTP — POST /user-auth/verify-login-otp
  Future<Response> verifyLoginOtp({
    required String email,
    required String otp,
  }) async {
    return await _dio.post(
      'users/verify-login-otp',
      data: {'email': email, 'otp': otp},
    );
  }

  // ✅ Resend Login OTP — POST /user-auth/resend-login-otp
  Future<Response> resendLoginOtp(String email) async {
    return await _dio.post('users/resend-login-otp', data: {'email': email});
  }
}
