// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

/// This file defines the DrugByCompanyScreen widget, which lists all medicines available under a specific company.
/// It displays the company's name in the app bar and shows a list of medicines. Each medicine is represented by a CustomDrugCard.
/// The screen includes a loading indicator while the medicines are being fetched and displays a message if no medicines are found.
/// Users can tap on a medicine to view its details.
///
/// Key sections of the code include:
/// - The `DrugByCompanyScreen` class: This is the main widget for displaying the list of medicines by company. It initializes the HomeScreenController and defines the UI layout.
/// - The `GetBuilder` widget: Used to rebuild the UI when the list of medicines changes. It wraps the ListView.separated widget that displays the medicines.
/// - The `ListView.separated` widget: Dynamically generates a list of CustomDrugCard widgets based on the medicines fetched from the HomeScreenController.
/// - The `CustomDrugCard` widget: Represents a single medicine in the list. It displays the medicine's name and allows users to tap on it to view more details.
/// - The loading and empty state indicators: Displayed while the medicines are being fetched or if no medicines are found, respectively.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/cards/custom_drug_card.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';

class DrugByCompanyScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();
  int companyId;
  String companyName;
  DrugByCompanyScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    homeScreenController.getAllDrugsByCompany(companyId);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawerScrimColor: Colors.black.withOpacity(0.7),
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(
          size: 32,
          color: kBrand800,
        ),
        foregroundColor: kBrand800,
        title: Text(
          companyName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              GetBuilder<HomeScreenController>(builder: (controller) {
                return Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 400,
                          child: homeScreenController.isDrugLoading.value == true
                              ? const Center(child: CustomCircularProgressIndicator())
                              : homeScreenController.drugByCompany.isNotEmpty
                                  ? ListView.separated(
                                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                      separatorBuilder: (context, index) => const SizedBox(
                                            height: 8,
                                          ),
                                      itemCount: homeScreenController.drugByCompany.length,
                                      itemBuilder: (context, index) {
                                        return CustomDrugCard(
                                          medicin: homeScreenController.drugByCompany[index],
                                        );
                                      })
                                  : const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          "There is no drugs in this company",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
