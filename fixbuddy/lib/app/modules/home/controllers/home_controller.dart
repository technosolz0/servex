import 'dart:convert';

import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/data/models/category_model.dart';
import 'package:fixbuddy/app/data/models/service_model.dart';
import 'package:fixbuddy/app/data/models/subcategory_model.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';
import 'package:fixbuddy/app/data/services/category_service.dart';
import 'package:fixbuddy/app/data/services/service_service.dart';
import 'package:fixbuddy/app/data/services/subcategory_service.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var username = ''.obs;
  var location = ''.obs;
  final RxInt selectedIndex = 0.obs;
  final categories = <CategoryModel>[].obs;
  final subcategories = <SubcategoryModel>[].obs;
  final services = <ServiceModel>[].obs;

  final CategoryApiService _categoryApiService = CategoryApiService();
  final SubcategoryApiService _subcategoryApiService = SubcategoryApiService();
  final ServiceApiService _serviceApiService = ServiceApiService();

  final LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserFromCache();
    fetchCategories();
    fetchSubcategories();
    fetchServices();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void loadUserFromCache() async {
    String? userJson = await _localStorage.pref.read(
      key: _localStorage.userDetailsKey,
    );
    if (userJson != null) {
      final user = UserCachedModel.fromJSON(jsonDecode(userJson));
      username.value = user.fullName;
      // location.value = user.address ?? 'No Address Provided';
    }
  }

  void fetchCategories() async {
    try {
      final data = await _categoryApiService.fetchCategories();
      categories.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    }
  }

  void fetchSubcategories() async {
    try {
      final data = await _subcategoryApiService.fetchSubcategories();
      subcategories.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subcategories');
    }
  }

  void fetchServices() async {
    try {
      final data = await _serviceApiService.fetchServices();
      services.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load services');
    }
  }

  // Function to open sub-category bottom sheet
  void openSubCategories(CategoryModel category) {
    // filter subcategories by category.id
    final selectedSubCategories = subcategories
        .where((sub) => sub.categoryId == category.id)
        .toList();

    if (selectedSubCategories.isEmpty) {
      Get.snackbar(
        'Coming Soon',
        'No sub-categories for ${category.name} added yet.',
      );
      return;
    }

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedSubCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final sub = selectedSubCategories[index];
                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      // show image from API or placeholder
                      if (sub.image != null)
                        Image.network(
                          '${ApiConstants.baseUrl}${sub.image}',
                          height: 36,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 36,
                              ),
                        )
                      else
                        const Icon(Icons.image, size: 36),
                      const SizedBox(height: 6),
                      Text(
                        sub.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
