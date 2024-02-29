// ignore_for_file: must_be_immutable

/// This file defines the CompaniesScreen widget, which displays a list of companies available in the PillCart application.
/// It shows a list of company tiles, each representing a company with its name and logo. Users can tap on a company tile to view more details.
/// The screen includes a loading indicator while the companies are being fetched and displays a message if no companies are found.
/// The list of companies is fetched from a backend service and displayed using a ListView.separated widget.
///
/// Key sections of the code include:
/// - The `CompaniesScreen` class: This is the main widget for displaying the list of companies. It initializes the HomeScreenController and defines the UI layout.
/// - The `GetBuilder` widget: Used to rebuild the UI when the list of companies changes. It wraps the ListView.separated widget that displays the companies.
/// - The `ListView.separated` widget: Dynamically generates a list of CompanyTile widgets based on the companies fetched from the HomeScreenController.
/// - The `CompanyTile` widget: Represents a single company in the list. It displays the company's name and logo and allows users to tap on it to view more details.
/// - The loading and empty state indicators: Displayed while the companies are being fetched or if no companies are found, respectively.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';
import 'package:pill_cart/widgets/tiles/custom_company_tile.dart';

class CompaniesScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();
  CompaniesScreen({super.key});

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
            'Companies'.tr,
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
                              itemCount: homeScreenController.companies.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 0),
                                        child: CompanyTile(
                                          company: homeScreenController.companies[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                    ),
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
