// ignore_for_file: must_be_immutable

/// This file defines the CategoriesScreen widget, which displays a list of categories available in the PillCart application.
/// It shows a list of category tiles, each representing a category with its name and icon. Users can tap on a category tile to view more details.
/// The screen includes a loading indicator while the categories are being fetched and displays a message if no categories are found.
/// The list of categories is fetched from a backend service and displayed using a ListView.separated widget.
///
/// Key sections of the code include:
/// - The `CategoriesScreen` class: This is the main widget for displaying the list of categories. It initializes the HomeScreenController and defines the UI layout.
/// - The `GetBuilder` widget: Used to rebuild the UI when the list of categories changes. It wraps the ListView.separated widget that displays the categories.
/// - The `ListView.separated` widget: Dynamically generates a list of CategoryTile widgets based on the categories fetched from the HomeScreenController.
/// - The `CategoryTile` widget: Represents a single category in the list. It displays the category's name and icon and allows users to tap on it to view more details.
/// - The loading and empty state indicators: Displayed while the categories are being fetched or if no categories are found, respectively.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';
import 'package:pill_cart/widgets/tiles/custom_category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawerScrimColor: Colors.black.withOpacity(0.7),
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(
            size: 32,
            color: kBrand800,
          ),
          foregroundColor: kBrand800,
          title: Text(
            'Categories'.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
    
        body: SafeArea(
          child: GetBuilder<HomeScreenController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: homeScreenController.isCategoriesAndCompaniesLoading.value == true
                          ? const Center(child: CustomCircularProgressIndicator())
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              clipBehavior: Clip.none,
                              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: homeScreenController.categories.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 0),
                                        child: CategoryTile(
                                          category: homeScreenController.categories[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
