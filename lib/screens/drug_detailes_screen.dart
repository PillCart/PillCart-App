// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, deprecated_member_use

/// This file defines the DrugDetailesScreen widget, which displays detailed information about a specific medicine.
/// It includes the medicine's trade name, generic name, category, company, amount, price, and expiration date.
/// Users can add the medicine to their cart, adjust the quantity, and see if the medicine is already in the cart.
/// The screen is designed to provide a comprehensive view of the medicine's details and facilitate easy addition to the cart.
///
/// Key sections of the code include:
/// - The `DrugDetailesScreen` class: This is the main widget for displaying the medicine's details. It initializes controllers and defines the UI layout.
/// - The `Positioned` widgets: Used to place the medicine's image at the top of the screen and the details container below it.
/// - The `ListView` widget: Contains the medicine's details, including trade name, generic name, category, company, amount, price, and expiration date.
/// - The `CustomCounterPlusButton` and `CustomCounterMinusButton` widgets: Allow users to adjust the quantity of the medicine in the cart.
/// - The `CPrimaryButton` widget: Provides a button for adding the medicine to the cart. It checks if the medicine is already in the cart and disables the button if so.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/widgets/buttons/custom_counter_minus_button.dart';
import 'package:pill_cart/widgets/buttons/custom_counter_plus_button.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/widgets/custom_snackbar.dart';
import 'package:pill_cart/widgets/text_fields/custom_counter_text_field.dart';

class DrugDetailesScreen extends StatelessWidget {
  TextEditingController counterController = TextEditingController();

  HomeScreenController homeScreenController = Get.find();
  CartController cartController = Get.find();

  final counterFormKey = GlobalKey<FormState>();
  Medicines medicin;
  bool inCart;

  DrugDetailesScreen({
    super.key,
    required this.medicin,
    required this.inCart,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.black.withOpacity(0.7),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image(
                  height: height / 5,
                  image: const AssetImage('images/drug1.jpg'),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              height: height - (height / 2.2),
              bottom: 0,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 16,
                      spreadRadius: 0,
                      offset: const Offset(0, -8),
                    ),
                  ],
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              //? trade name
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidCopyright,
                                  color: kBrand800,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Trade Name:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    medicin.tradeName.toString(),
                                    style: customLightTheme.textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                              height: 32,
                            ),
                            Row(
                              //? generic name
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.flask,
                                  color: kBrand800,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Generic Name:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    medicin.genericName.name.toString(),
                                    style: customLightTheme.textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                              height: 32,
                            ),
                            Row(
                              //? category name
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.list,
                                  color: kBrand800,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Category:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    medicin.category.name.toString(),
                                    style: customLightTheme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                              height: 32,
                            ),
                            Row(
                              //? company name
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.industry,
                                  color: kBrand800,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Company:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    medicin.company.name.toString(),
                                    style: customLightTheme.textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                              height: 32,
                            ),
                            width > 370
                                ? Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      Row(
                                        //? amount
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          Text(
                                            medicin.amount.toString(),
                                            style: customLightTheme.textTheme.headlineSmall?.copyWith(),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'unit'.tr,
                                            style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 32,
                                        width: 1,
                                        color: Colors.grey[400],
                                      ),
                                      const Spacer(),
                                      Row(
                                        //? price
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          Text(
                                            medicin.price.toString(),
                                            style: customLightTheme.textTheme.headlineSmall?.copyWith(),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            '\$',
                                            style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                              color: kBrand800,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 24,
                                      )
                                    ],
                                  )
                                : Column(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Row(
                                        //? price
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.moneyBill,
                                            color: kBrand800,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Price:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            medicin.price.toString(),
                                            style: customLightTheme.textTheme.headlineSmall?.copyWith(),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            '\$',
                                            style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                              color: kBrand800,
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey[400],
                                        height: 32,
                                      ),
                                      Row(
                                        //? amount
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.box,
                                            color: kBrand800,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Amount:', style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: kBrand800)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            medicin.amount.toString(),
                                            style: customLightTheme.textTheme.headlineSmall?.copyWith(),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'unit'.tr,
                                            style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                              height: 32,
                            ),
                            width > 370
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Row(
                                        //? Expiring Date
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.warning,
                                            color: red,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Expiring Date:'.tr, style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: red)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${medicin.expiringDay}/${medicin.expiringMonth}/${medicin.expiringYear}',
                                            style: customLightTheme.textTheme.bodySmall?.copyWith(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.warning,
                                            color: red,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Expiring Date:', style: customLightTheme.textTheme.titleSmall?.copyWith(fontSize: 16, color: red)),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '${medicin.expiringDay}/${medicin.expiringMonth}/${medicin.expiringYear}',
                                        style: customLightTheme.textTheme.bodySmall?.copyWith(
                                            // fontSize: 26,
                                            ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      inCart
                          ? Column(
                              children: [
                                Text(
                                  'You can\'t edit quantity from the cart'.tr,
                                  style: customLightTheme.textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                cartController.inCart.contains(medicin.id)
                                    ? Text(
                                        'Already in cart'.tr,
                                        style: customLightTheme.textTheme.bodySmall?.copyWith(color: red, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )
                                    : const SizedBox(
                                        width: 0,
                                      ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          CustomCounterPlusButton(
                                            cartController: cartController,
                                            medicin: medicin,
                                            counterController: counterController,
                                          ),
                                          Expanded(
                                            child: Form(
                                              key: counterFormKey,
                                              child: CounterTextField(
                                                cartController: cartController,
                                                medicin: medicin,
                                                counterController: counterController,
                                              ),
                                            ),
                                          ),
                                          CustomCounterMinusButton(
                                            cartController: cartController,
                                            medicin: medicin,
                                            counterController: counterController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: CPrimaryButton(
                                        isEnabled: cartController.inCart.contains(medicin.id) ? false : true,
                                        color: kBrand600,
                                        buttonText: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Add to cart'.tr,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Icon(Icons.shopping_cart)
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (!counterController.text.isNumericOnly) {
                                            customSnackbar('Quantity have letter!?'.tr, 'please enter only numbers'.tr, 'error', 1300, Colors.white);
                                          } else if (int.parse(counterController.text) > medicin.amount) {
                                            customSnackbar('too far'.tr, "enoght amount".tr, 'error', 6000000, Colors.white);
                                          } else if (counterController.text.isNotEmpty && int.parse(counterController.text) != 0) {
                                            if (counterFormKey.currentState!.validate()) {
                                              cartController.AddToCart(medicin, int.parse(counterController.text), medicin.id);
                                              Get.back();
                                            }
                                          } else {
                                            customSnackbar('Why?'.tr, 'Add Some first'.tr, 'error', 1300, Colors.white);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    splashRadius: 24,
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 24,
                      color: kBrand800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}