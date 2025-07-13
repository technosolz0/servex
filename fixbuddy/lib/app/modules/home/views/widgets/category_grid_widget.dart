import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/modules/home/controllers/home_controller.dart';
import 'package:fixbuddy/app/data/models/category_model.dart';

class CategoryGridWidget extends StatelessWidget {
  final Function(CategoryModel) onCategoryTap;

  const CategoryGridWidget({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return GestureDetector(
            onTap: () => onCategoryTap(category),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.network(
                    '${ApiConstants.baseUrl}${category.image}',
                    height: 45,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: AppColors.secondaryColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
