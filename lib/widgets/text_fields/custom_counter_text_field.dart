import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/utils/theme.dart';

class CounterTextField extends StatelessWidget {
  const CounterTextField({
    super.key,
    required this.cartController,
    required this.medicin,
    required this.counterController,
  });

  final CartController cartController;
  final Medicines medicin;
  final TextEditingController counterController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabled: cartController.inCart.contains(medicin.id) ? false : true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        label: Text(
          'Quantity'.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: !cartController.inCart.contains(medicin.id)
            ? customLightTheme.textTheme.labelSmall?.copyWith(
                color: kBrand800,
              )
            : customLightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.grey[700],
              ),
        filled: true,
        fillColor: !cartController.inCart.contains(medicin.id) ? Colors.grey[100] : Colors.grey[400],
        errorStyle: customLightTheme.textTheme.labelSmall?.copyWith(
          color: red,
          height: 1,
        ),
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: kBrand800,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: counterController,
    );
  }
}
