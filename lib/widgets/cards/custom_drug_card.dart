// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/screens/drug_detailes_screen.dart';
import 'package:pill_cart/utils/theme.dart';

// CustomDrugCard is a stateless widget that represents a custom drug card in the UI.
// It displays information about a medicine, including its trade name, generic name, category,
// amount, and price. It also provides an interactive element that, when tapped,
// displays a detailed view of the medicine in a dialog.
class CustomDrugCard extends StatelessWidget {
  // Instance of HomeScreenController to manage interactions related to the home screen.
  HomeScreenController homeScreenController = Get.find();

  // The medicine object that this card represents.
  Medicines medicin;

  // Constructor for CustomDrugCard, taking a key and a required medicine object.
  CustomDrugCard({
    super.key,
    required this.medicin,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the width of the screen to adjust the layout accordingly.
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // When the card is tapped, display a dialog with detailed information about the medicine.
        Get.dialog(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 70),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: DrugDetailesScreen(
                  medicin: medicin,
                  inCart: false,
                ),
              ),
            ),
            barrierColor: Colors.black.withOpacity(0.5),
            barrierDismissible: true,
            transitionCurve: Curves.easeOutSine,
            transitionDuration: const Duration(milliseconds: 300),
            useSafeArea: true);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The main container for the card, with a shadow and rounded corners.
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: -8,
                  offset: const Offset(0, 4),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 100,
            child: width > 330
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        // Image container for the medicine's image.
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 4,
                                spreadRadius: -2,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          width: 80,
                          height: 80,
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Image(
                              image: AssetImage('images/drug1.jpg'),
                              height: 23,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        // Text container for the medicine's details.
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the medicine's trade name.
                              Text(
                                medicin.tradeName.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // Display the medicine's generic name.
                              Text(
                                medicin.genericName.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              // Display the medicine's category.
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.list,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      medicin.category.name.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: customLightTheme.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        // Text container for the medicine's details in a more compact layout.
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the medicine's trade name.
                              Text(
                                medicin.tradeName.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // Display the medicine's generic name.
                              Text(
                                medicin.genericName.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: customLightTheme.textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              // Display the medicine's category.
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.list,
                                    size: 14,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      medicin.category.name.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: customLightTheme.textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ),
          ),
          // Positioned widgets for displaying the medicine's amount and price.
          PositionedDirectional(
            top: 4,
            end: 4,
            child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(16), topEnd: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the medicine's amount.
                    Text(
                      medicin.amount.toString(),
                      style: customLightTheme.textTheme.labelMedium,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'unit'.tr,
                      style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            end: 12,
            bottom: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the medicine's price.
                Text(
                  medicin.price.toString(),
                  style: customLightTheme.textTheme.labelMedium,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '\$',
                  style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
