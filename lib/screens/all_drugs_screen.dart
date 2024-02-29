// ignore_for_file: must_be_immutable

/// This file defines the OrdersScreen widget, which displays a list of the user's past orders in the PillCart application.
/// It shows a list of order tiles, each representing a past order with its details such as order date, total price, and status.
/// Users can tap on an order tile to view more details about the order, including the items purchased and their quantities.
/// The screen includes a loading indicator while the orders are being fetched and displays a message if no orders are found.
/// The list of orders is fetched from a backend service and displayed using a ListView.separated widget.
///
/// Key sections of the code include:
/// - The `OrdersScreen` class: This is the main widget for displaying the user's past orders. It initializes the OrdersController and defines the UI layout.
/// - The `GetBuilder` widget: Used to rebuild the UI when the list of orders changes. It wraps the ListView.separated widget that displays the orders.
/// - The `ListView.separated` widget: Dynamically generates a list of OrderTile widgets based on the orders fetched from the OrdersController.
/// - The `OrderTile` widget: Represents a single order in the list. It displays the order's details and allows users to tap on it to view more details.
/// - The loading and empty state indicators: Displayed while the orders are being fetched or if no orders are found, respectively.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/cards/custom_drug_card.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';

class AllDrugsScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();

  AllDrugsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(
            size: 32,
            color: kBrand800,
          ),
          foregroundColor: kBrand800,
          title: Text(
            'AllDrugsAPT'.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: GetBuilder<HomeScreenController>(
                builder: (controller) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Container(
                          child: homeScreenController.isDrugLoading.value == true
                              ? const Center(child: CustomCircularProgressIndicator())
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(
                                      decelerationRate: ScrollDecelerationRate.fast,
                                    ),
                                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 12,
                                    ),
                                    itemCount: homeScreenController.medicines.length,
                                    itemBuilder: (context, index) {
                                      return CustomDrugCard(
                                        medicin: homeScreenController.medicines[index],
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
