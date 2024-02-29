import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/models/medicines_model.dart';

class CustomCounterPlusButton extends StatelessWidget {
  const CustomCounterPlusButton({
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
    return GestureDetector(
      onLongPress: !cartController.inCart.contains(medicin.id)
          ? () {
              if (counterController.text.isEmpty) {
                counterController.text = '0';
                int counter = int.parse(counterController.text) + 100;
                counterController.text = counter.toString();
              } else {
                int counter = int.parse(counterController.text) + 100;
                counterController.text = counter.toString();
              }
            }
          : null,
      onTap: !cartController.inCart.contains(medicin.id)
          ? () {
              if (counterController.text.isEmpty) {
                counterController.text = '0';
                int counter = int.parse(counterController.text) + 10;
                counterController.text = counter.toString();
              } else {
                int counter = int.parse(counterController.text) + 10;
                counterController.text = counter.toString();
              }
            }
          : null,
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }
}