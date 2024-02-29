// ignore_for_file: must_be_immutable

/// This file defines the CartScreen widget, which displays the user's current shopping cart in the PillCart application.
/// It shows a list of items in the cart, each represented by a CustomDrugInCartCard widget. Users can adjust the quantity of each item or remove it from the cart.
/// The screen includes a total price display at the bottom, which updates as items are added, removed, or quantities are changed.
/// Users can proceed to checkout by tapping the "Order" button, which triggers the order processing flow.
///
/// Key sections of the code include:
/// - The `CartScreen` class: This is the main widget for displaying the user's shopping cart. It initializes the CartController and defines the UI layout.
/// - The `GetBuilder` widget: Used to rebuild the UI when the cart's contents change. It wraps the ListView.separated widget that displays the items in the cart.
/// - The `ListView.separated` widget: Dynamically generates a list of CustomDrugInCartCard widgets based on the items in the cart.
/// - The `CustomDrugInCartCard` widget: Represents a single item in the cart. It displays the item's details and allows users to adjust the quantity or remove the item.
/// - The total price display: Shows the current total price of the items in the cart, updating in real-time as changes are made.
/// - The "Order" button: Triggers the order processing flow when tapped, allowing the user to complete their purchase.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/widgets/cards/custom_drug_in_cart_card.dart';
import 'package:pill_cart/utils/theme.dart';

class CartScreen extends StatelessWidget {
  CartController cartController = Get.find();
  HomeScreenController homeScreenController = Get.find();

  CartScreen({super.key});

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
          title: Text('CartScreeAPT'.tr),
        ),
        body: GetBuilder<CartController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: !cartController.isCartEmpty.value
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 8,
                                  ),
                              itemCount: cartController.medicinsInCart.length,
                              itemBuilder: (context, index) {
                                return CustomDrugInCartCard(
                                  medicin: cartController.medicinsInCart[index],
                                  quantity: cartController.amount[index],
                                );
                              }),
                        ),
                        CPrimaryButton(
                          isEnabled: true,
                          buttonText: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('orderB'.tr),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                Icons.send_rounded,
                                size: 24,
                              ),
                            ],
                          ),
                          color: kBrand500,
                          onPressed: () async {
                            await cartController.SendOrder();
                            await cartController.cleanCart();
                            cartController.inCart = [];
                            cartController.medicinsInCart = [];
                            cartController.amount = [];
                            cartController.CartModel = [];
                            cartController.isCartEmpty(true);
                            cartController.update();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your cart is empty!".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            homeScreenController.changeTabIndex(0);
                          },
                          child: Text(
                            "Fill it!".tr,
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
                  ),
          );
        }),
      ),
    );
  }
}
