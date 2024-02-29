// ignore_for_file: must_be_immutable

/// This file defines the OrdersScreen widget, which serves as the screen for viewing and managing orders within the PillCart application.
/// It displays a list of orders fetched from the backend, allowing users to view details of each order.
/// The screen uses a ListView to efficiently display the orders, with a loading indicator shown while the orders are being fetched.
/// It also provides a message and a prompt for users to make orders if they haven't placed any yet.
///
/// Key sections of the code include:
/// - The `OrdersScreen` class: This is the main widget for the orders screen. It initializes the CartController and HomeScreenController, and defines the UI layout.
/// - The `ListView.separated` widget: Provides the list of orders. It includes a separator between each order for better visual separation.
/// - The `CustomOrderCard` widget: Represents each order in the list. It displays the order details in a custom card format.
/// - The `isOrdersLoading` and `isMyOrdersEmpty` properties: Used to control the display of the loading indicator and the message for empty orders.
/// - The `GestureDetector` widget: Provides an interactive element for users to navigate to the home screen to make orders.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/cards/custom_order_card.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';

class OrdersScreen extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  HomeScreenController homeScreenController = Get.find();

  OrdersScreen({super.key});
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
          title: Text('My Orders'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<CartController>(
            builder: (controller) {
              return Flex(
                direction: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: cartController.isOrdersLoading.value
                        ? const Center(child: CustomCircularProgressIndicator())
                        : cartController.isMyOrdersEmpty.value
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("You haven't placed any order... yet!".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        homeScreenController.changeTabIndex(0);
                                        // Get.offNamed('/dash');
                                      },
                                      child: Text(
                                        "Make some orders".tr,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                          color: kBrand800,
                                          fontFamily: 'Lexend_Bold',
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(
                                    decelerationRate: ScrollDecelerationRate.fast,
                                  ),
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  separatorBuilder: (context, index) => const SizedBox(
                                    height: 8,
                                  ),
                                  itemCount: cartController.myOrders!.myOrders.length,
                                  itemBuilder: (context, index) {
                                    return CustomOrderCard(order: cartController.myOrders!.myOrders[index]);
                                  },
                                ),
                              ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
