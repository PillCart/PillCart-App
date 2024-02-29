// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

/// This file contains the `CustomOrderCard` widget, which is used to display
/// a custom order card in the application. It includes details about the order,
/// such as the date, total price, order status, and payment status. Users can
/// interact with the card to view order details or delete the order if it's
/// in preparation.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/MyOrderModel.dart';
import 'package:pill_cart/screens/order_detailes_screen.dart';
import 'package:pill_cart/widgets/buttons/custom_outline_button.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/utils/theme.dart';

/// `CustomOrderCard` is a stateless widget that displays an order card with
/// details such as the order date, total price, and status. It allows users to
/// interact with the card to view more details or delete the order if it's in
/// preparation
class CustomOrderCard extends StatelessWidget {
  CartController cartController = Get.find();
  MyOrderElement order;

  CustomOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        cartController.ShowdetailesOfOrder(order.id);

        Get.dialog(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: height * 0.19),
              child: Container(
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: OrderDetailesScreen(order: order)),
            ),
            barrierDismissible: true,
            transitionDuration: const Duration(milliseconds: 300),
            useSafeArea: true);
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              GestureDetector(
                onTap: order.deliveryStatus == 'in preparation'
                    ? () {
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
                                            'Delete!'.tr,
                                            style: customLightTheme.textTheme.bodyLarge?.copyWith(
                                              color: red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'want to delete this order?'.tr,
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
                                                    await cartController.deleteOrder(order.id);
                                                    await cartController.ShowMyOrder();
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
                      }
                    : null,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        FontAwesomeIcons.trash,
                        size: 24,
                        color: order.deliveryStatus == 'in preparation' ? red.withOpacity(0.8) : Colors.grey[400]?.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 70,
                      width: 1,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
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
                              Expanded(
                                child: Text(
                                  '${order.day}/${order.month}/${order.year}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: customLightTheme.textTheme.bodyLarge?.copyWith(color: Colors.black, height: 0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            const Icon(
                              FontAwesomeIcons.coins,
                              size: 20,
                              color: kBrand800,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              order.totalPrice >= 1000 ? '\$${order.totalPrice / 1000}k' : '\$ ${order.totalPrice}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: customLightTheme.textTheme.bodyLarge?.copyWith(color: Colors.black, height: 0.5),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          '- Order Status:'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: customLightTheme.textTheme.labelSmall?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            order.deliveryStatus == 'in preparation'
                                ? 'Preparing...'.tr
                                : order.deliveryStatus == 'sent'
                                    ? 'Sent'.tr
                                    : 'Recevied'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: customLightTheme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: order.deliveryStatus == 'in preparation'
                                    ? Colors.black
                                    : order.deliveryStatus == 'sent'
                                        ? kBrand800
                                        : Colors.green[600]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          '- Payment Status:'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: customLightTheme.textTheme.labelSmall?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            order.paymentStatus == 'paid' ? 'Paid'.tr : 'Unpaid'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: customLightTheme.textTheme.bodySmall?.copyWith(color: order.paymentStatus == 'paid' ? Colors.yellow[700] : Colors.black, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
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
