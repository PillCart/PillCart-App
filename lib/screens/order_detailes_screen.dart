// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

/// This file contains the OrderDetailesScreen class, which is a StatelessWidget
/// responsible for displaying the details of a specific order. It uses the GetX
/// package for state management and the CartController for accessing order details.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/MyOrderModel.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';

/// OrderDetailesScreen is a StatelessWidget that displays the details of a specific order.
/// It takes an instance of MyOrderElement as a parameter to display the order's details.
class OrderDetailesScreen extends StatelessWidget {
  CartController cartController = Get.find();

  MyOrderElement order;

  /// Constructor for OrderDetailesScreen.
  /// @param order The order whose details are to be displayed.
  OrderDetailesScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // The main build method returns a Scaffold widget that contains the UI for displaying order details.
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GetBuilder<CartController>(builder: (controller) {
              // This GetBuilder widget listens for changes in the CartController and rebuilds the UI accordingly.
              return Column(
                children: [
                  // Header section displaying the title 'Your Bill'.
                  Opacity(
                    opacity: 0.7,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your Bill'.tr,
                              style: const TextStyle(
                                fontSize: 24,
                                color: kBrand800,
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Lexend_Bold',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Table section displaying the order details.
                  Expanded(
                    child: Column(
                      children: [
                        // Table header displaying column titles.
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'trade name'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                //height: 18,
                                width: 1,
                                color: Colors.grey,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'amount'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                //height: 18,
                                width: 1,
                                color: Colors.grey,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'price'.tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Table rows displaying the order details.
                        cartController.isOrderDetailesLoading.value
                            ? const Expanded(child: Center(child: CustomCircularProgressIndicator()))
                            : Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return Container(
                                              height: 1,
                                              color: Colors.grey,
                                            );
                                          },
                                          itemCount: cartController.detailsOrder!.detailsForOrder.length,
                                          itemBuilder: (contxet, index) {
                                            // Each row in the table displays the trade name, amount, and price for each item in the order.
                                            return SizedBox(
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 8,
                                                    child: Text(
                                                      '-',
                                                      style: customLightTheme.textTheme.labelSmall,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Text(
                                                        cartController.detailsOrder!.detailsForOrder[index].tradeName,
                                                        style: customLightTheme.textTheme.labelSmall?.copyWith(fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    //height: 18,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsetsDirectional.only(end: 2, start: 8),
                                                          child: Text(
                                                            cartController.detailsOrder!.detailsForOrder[index].amount >= 1000 ? '${cartController.detailsOrder!.detailsForOrder[index].amount / 1000} k' : cartController.detailsOrder!.detailsForOrder[index].amount.toString(),
                                                            style: customLightTheme.textTheme.labelSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        Text(
                                                          'unit'.tr,
                                                          style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    //height: 18,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsetsDirectional.only(end: 2, start: 8),
                                                          child: Text(
                                                            (cartController.detailsOrder!.detailsForOrder[index].price * cartController.detailsOrder!.detailsForOrder[index].amount >= 1000)
                                                                ? '${(cartController.detailsOrder!.detailsForOrder[index].price * cartController.detailsOrder!.detailsForOrder[index].amount) / 1000} k'
                                                                : (cartController.detailsOrder!.detailsForOrder[index].price * cartController.detailsOrder!.detailsForOrder[index].amount).toString(),
                                                            style: customLightTheme.textTheme.labelSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        Text(
                                                          '\$',
                                                          style: customLightTheme.textTheme.labelSmall?.copyWith(color: kBrand800, fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // Total price and date of the order.
                                          Row(
                                            textBaseline: TextBaseline.alphabetic,
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.coins,
                                                size: 20,
                                                color: kBrand800,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                order.totalPrice >= 1000 ? '${order.totalPrice / 1000} k \$' : '${order.totalPrice} \$',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: customLightTheme.textTheme.bodyLarge?.copyWith(color: Colors.black, height: 0.5),
                                              )
                                            ],
                                          ),
                                          Row(
                                            textBaseline: TextBaseline.alphabetic,
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.calendarCheck,
                                                size: 20,
                                                color: kBrand800,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${order.day}/${order.month}/${order.year}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: customLightTheme.textTheme.bodyLarge?.copyWith(color: Colors.black, height: 0.5),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          // This widget is a back button at the top left of the screen, using FontAwesomeIcons.arrowLeft.
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
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
