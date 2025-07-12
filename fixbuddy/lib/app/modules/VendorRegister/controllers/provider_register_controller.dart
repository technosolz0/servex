import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fixbuddy/app/modules/VendorRegister/models/service_provider_register_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixbuddy/app/modules/VendorRegister/services/provider_api_service.dart';
import 'package:fixbuddy/app/routes/app_routes.dart';

class ProviderRegisterController extends GetxController {
  final category = ''.obs;
  final selectedLocations = <String>[].obs;

  // Address
  final addressController = TextEditingController();
  final roadController = TextEditingController();
  final landmarkController = TextEditingController();
  final pinCodeController = TextEditingController();

  // Experience & About
  final experienceController = TextEditingController();
  final aboutController = TextEditingController();

  // Bank
  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final confirmAccountNumberController = TextEditingController();
  final ifscController = TextEditingController();

  // Document Uploads
  final Rxn<File> profilePic = Rxn<File>();
  final Rxn<File> addressProof = Rxn<File>();
  final Rxn<File> bankStatement = Rxn<File>();

  final isLoading = false.obs;

  final ProviderApiService _apiService = ProviderApiService();

  Future<void> pickProfilePic() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) profilePic.value = File(picked.path);
  }

  Future<void> pickAddressProof() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) addressProof.value = File(result.files.single.path!);
  }

  Future<void> pickBankStatement() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) bankStatement.value = File(result.files.single.path!);
  }

  Future<void> registerProvider() async {
    if (category.value.isEmpty ||
        selectedLocations.isEmpty ||
        addressController.text.isEmpty ||
        experienceController.text.isEmpty ||
        bankNameController.text.isEmpty ||
        accountNumberController.text.isEmpty ||
        confirmAccountNumberController.text.isEmpty ||
        ifscController.text.isEmpty ||
        profilePic.value == null ||
        addressProof.value == null ||
        bankStatement.value == null) {
      Get.snackbar('Error', 'Please fill all required fields.');
      return;
    }

    if (accountNumberController.text != confirmAccountNumberController.text) {
      Get.snackbar('Error', 'Account numbers do not match.');
      return;
    }

    isLoading.value = true;

    try {
      /// ✅ Create model instance
      final model = ServiceProviderRegisterModel(
        category: category.value,
        serviceLocations: selectedLocations,
        address: addressController.text,
        road: roadController.text,
        landmark: landmarkController.text,
        pinCode: pinCodeController.text,
        experienceYears: int.tryParse(experienceController.text),
        about: aboutController.text,
        bankName: bankNameController.text,
        accountName: accountNameController.text,
        accountNumber: accountNumberController.text,
        ifscCode: ifscController.text,
        profilePic: profilePic.value!,
        addressProof: addressProof.value!,
        bankStatement: bankStatement.value!,
      );

      /// ✅ Call the clean new register method
      await _apiService.registerServiceProvider(model);

      Get.snackbar('Success', 'Registered successfully!');
      Get.offAllNamed(Routes.mainScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to register provider.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    roadController.dispose();
    landmarkController.dispose();
    pinCodeController.dispose();
    experienceController.dispose();
    aboutController.dispose();
    bankNameController.dispose();
    accountNameController.dispose();
    accountNumberController.dispose();
    confirmAccountNumberController.dispose();
    ifscController.dispose();
    super.onClose();
  }
}
