/// This file contains the definition for the `CategoryTile` widget.
/// This widget is used to display a category tile in the application's UI.
/// It takes a `Categories` object as input and displays the category's name
/// along with an icon. When tapped, it navigates to the `DrugByCategoryScreen`
/// for the selected category.


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/categories_model.dart';
import 'package:pill_cart/screens/drug_by_category_screen.dart';
import 'package:pill_cart/utils/theme.dart';

/// A stateless widget that displays a category tile.
///
/// This widget is designed to be used in a list of categories, displaying
/// the category's name and an icon. When tapped, it navigates to the
/// `DrugByCategoryScreen` for the selected category.
class CategoryTile extends StatelessWidget {
  /// The category to be displayed.
  final Categories category;

  /// Creates a new `CategoryTile` widget.
  ///
  /// @param category The category to be displayed.
  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DrugByCategoryScreen(
              categoryId: category.id,
              categoryName: category.name,
            ),);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              blurRadius:  8,
              spreadRadius: -8,
              offset:const Offset(0,  4),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  16, vertical:  12),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.list,
                size:  14,
                color: kBrand800,
              ),
              const SizedBox(
                width:  8,
              ),
              Expanded(
                child: Text(
                  category.name,
                  style: customLightTheme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}