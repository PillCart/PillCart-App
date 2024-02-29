import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/widgets/custom_snackbar.dart';

class CustomCounterMinusButton extends StatelessWidget {
  const CustomCounterMinusButton({
    Key? key,
    required this.cartController,
    required this.medicin,
    required this.counterController,
  }) : super(key: key);

  final CartController cartController;
  final Medicines medicin;
  final TextEditingController counterController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: !cartController.inCart.contains(medicin.id)
          ? () {
              if (counterController.text.isEmpty) {
                customSnackbar('Why?'.tr, 'Add Some first'.tr, 'error', 1500, Colors.white);
              } else if (int.parse(counterController.text) < 100) {
                customSnackbar('Rel'.tr, 'negative qunatity'.tr, 'error', 1500, Colors.white);
              } else {
                int counter = int.parse(counterController.text) - 100;
                counterController.text = counter.toString();
              }
            }
          : null,
      onTap: !cartController.inCart.contains(medicin.id)
          ? () {
              if (counterController.text.isEmpty) {
                customSnackbar('Why?'.tr, 'Add Some first'.tr, 'error', 1500, Colors.white);
              } else if (int.parse(counterController.text) < 10) {
                customSnackbar('Rel'.tr, 'negative qunatity'.tr, 'error', 1500, Colors.white);
              } else {
                int counter = int.parse(counterController.text) - 10;
                counterController.text = counter.toString();
              }
            }
          : null,
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          FontAwesomeIcons.minus,
        ),
      ),
    );
  }
}