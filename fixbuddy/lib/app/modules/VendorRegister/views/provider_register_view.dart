import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:fixbuddy/app/modules/VendorRegister/controllers/provider_register_controller.dart';
import 'package:fixbuddy/app/modules/VendorRegister/views/widgets/address_details_section.dart';
import 'package:fixbuddy/app/modules/VendorRegister/views/widgets/bank_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderRegisterView extends StatelessWidget {
  final controller = Get.put(ProviderRegisterController());
  final categories = ['Electrician', 'Plumber', 'Carpenter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Registration'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.blackColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: controller.category.value.isNotEmpty
                    ? controller.category.value
                    : null,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => controller.category.value = value!,
                decoration: InputDecoration(
                  labelText: 'Category',
                  filled: true,
                  fillColor: AppColors.lightgrayColor,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Address Section
              AddressDetailsSection(controller: controller),
              const SizedBox(height: 16),

              // Experience
              TextFormField(
                controller: controller.experienceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Years of Experience',
                  filled: true,
                  fillColor: AppColors.lightgrayColor,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // About
              TextFormField(
                controller: controller.aboutController,
                decoration: InputDecoration(
                  labelText: 'About',
                  filled: true,
                  fillColor: AppColors.lightgrayColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Bank Details Section
              BankDetailsSection(controller: controller),
              const SizedBox(height: 24),
              // Document Uploads Section
              Text(
                'Upload Documents',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: controller.pickProfilePic,
                child: const Text('Capture Profile Photo'),
              ),
              if (controller.profilePic.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Image.file(controller.profilePic.value!, height: 100),
                ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: controller.pickAddressProof,
                child: const Text('Upload Address Proof'),
              ),
              if (controller.addressProof.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    controller.addressProof.value!.path.split('/').last,
                  ),
                ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: controller.pickBankStatement,
                child: const Text('Upload Bank Statement'),
              ),
              if (controller.bankStatement.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    controller.bankStatement.value!.path.split('/').last,
                  ),
                ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.registerProvider,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
