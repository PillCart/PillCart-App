// ignore_for_file: must_be_immutable

/// This file contains the definition for the `CustomDrugInCartCard` widget, which is used to display
/// a drug item in the cart with its details and actions. It includes functionality for viewing
/// drug details, adjusting the quantity, and deleting the item from the cart.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/screens/drug_detailes_screen.dart';
import 'package:pill_cart/widgets/buttons/custom_outline_button.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/utils/theme.dart';

/// `CustomDrugInCartCard` is a stateless widget that displays a drug item in the cart.
/// It takes a `Medicines` object and a quantity as input and provides functionality
/// to view drug details, adjust the quantity, and delete the item from the cart.
class CustomDrugInCartCard extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();
  CartController cartController = Get.find();
  Medicines medicin;
  int quantity;

  /// Constructor for `CustomDrugInCartCard` that initializes the drug item and its quantity.
  CustomDrugInCartCard({
    super.key,
    required this.medicin,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // The main build method that returns the widget tree for the `CustomDrugInCartCard`.
    // It uses a `GestureDetector` to handle taps on the card, which opens a dialog
    // with the drug details. It also includes a delete button that opens a confirmation
    // dialog to delete the item from the cart.
    return GestureDetector(
      onTap: () {
        // Code to show a dialog with drug details
        Get.dialog(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 70),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: DrugDetailesScreen(
                  medicin: medicin,
                  inCart: true,
                ),
              ),
            ),
            barrierDismissible: true,
            transitionCurve: Curves.easeOutSine,
            transitionDuration: const Duration(milliseconds: 300),
            useSafeArea: true);
      },
      child: Container(
        // Code to build the UI for the drug item in the cart
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.9),
              blurRadius: 8,
              spreadRadius: -8,
              offset: const Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: width > 330
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Center(
                            child: SizedBox(
                              height: 240,
                              child: Center(
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white.withOpacity(0.8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Remove!'.tr,
                                            style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                              color: red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'want to remove this drug?'.tr,
                                            textAlign: TextAlign.center,
                                            style: customLightTheme.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: COutlineButton(
                                                  color: red,
                                                  buttonText: 'Cancel'.tr,
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: CPrimaryButton(
                                                  isEnabled: true,
                                                  color: red,
                                                  buttonText: Text(
                                                    'Remove'.tr,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  onPressed: () async {
                                                    await cartController.deleteFromCart(medicin, medicin.id, quantity);
                                                    cartController.update();
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          transitionCurve: Curves.easeOutSine,
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.trash,
                          size: 24,
                          color: red.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: -1,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 60,
                      height: 60,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(
                            'images/drug1.jpg',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicin.tradeName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: customLightTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Quantity:'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.labelSmall?.copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      quantity.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'unit'.tr,
                                      style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicin.tradeName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: customLightTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Quantity:'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.labelSmall?.copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      quantity.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'unit'.tr,
                                      style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Center(
                            child: SizedBox(
                              height: 240,
                              child: Center(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Dialog(
                                    elevation: 16,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.white.withOpacity(0.7)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Delete!'.tr,
                                              style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                                color: red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Want to delete this order?'.tr,
                                              textAlign: TextAlign.center,
                                              style: customLightTheme.textTheme.bodyMedium,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: COutlineButton(
                                                    color: red,
                                                    buttonText: 'Cancel'.tr,
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: CPrimaryButton(
                                                    isEnabled: true,
                                                    color: red,
                                                    buttonText: Text(
                                                      'Delete'.tr,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    onPressed: () async {
                                                      await cartController.deleteFromCart(medicin, medicin.id, quantity);
                                                      cartController.update();
                                                      Get.back();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          transitionCurve: Curves.easeOutSine,
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 1,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              FontAwesomeIcons.trash,
                              size: 24,
                              color: red.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
