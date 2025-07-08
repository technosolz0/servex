import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';
import 'package:fixbuddy/app/services/auth_api_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final isLoading = false.obs;

  final AuthApiService _apiService = AuthApiService();
  final LocalStorage _localStorage = LocalStorage();

  String get otp => otpControllers.map((controller) => controller.text).join();

  Future<void> handleOtpVerification(String email, String flowType) async {
    if (otp.length < 6) {
      Get.snackbar(
        'Invalid',
        'Please enter complete 6-digit OTP',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      if (flowType == 'register') {
        await verifyRegisterOtp(email);
      } else if (flowType == 'login') {
        await verifyLoginOtp(email);
      } else {
        Get.snackbar(
          'Error',
          'Unknown flow type',
          backgroundColor: AppColors.errorColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Verification failed: $e',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyRegisterOtp(String email) async {
    final response = await _apiService.verifyRegistrationOtp(
      email: email,
      otp: otp,
    );

    if (response.statusCode == 200) {
      await _saveUserSession(response.data);
      Get.snackbar(
        'Success',
        'Registration successful!',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.mainScreen);
    } else {
      Get.snackbar(
        'Error',
        'Invalid OTP',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verifyLoginOtp(String email) async {
    final response = await _apiService.verifyLoginOtp(email: email, otp: otp);

    if (response.statusCode == 200) {
      await _saveUserSession(response.data);
      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: AppColors.successColor,
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.mainScreen);
    } else {
      Get.snackbar(
        'Error',
        'Invalid OTP',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _saveUserSession(Map<String, dynamic> responseData) async {
    await _localStorage.setToken(responseData['access_token']);

    final user = responseData['user'];
    await _localStorage.setUserDetails(
      UserCachedModel(
        id: user['id'],
        fullName: user['name'],
        email: user['email'],
        mobile: user['mobile'],
        profilePhoto: '',
      ),
    );
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
