// ignore_for_file: must_be_immutable

/// A custom widget that displays a category card with a clickable area.
/// This widget is designed to be used in a list of categories, allowing
/// users to navigate to a detailed view of the category's content.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/categories_model.dart';
import 'package:pill_cart/screens/drug_by_category_screen.dart';
import 'package:pill_cart/utils/theme.dart';

class CategoryCard extends StatelessWidget {
  /// The category data to be displayed on the card.
  final Categories category;

  /// Constructor for the CategoryCard widget.
  ///
  /// @param category: The category data to be displayed.
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 8, 10),
      child: GestureDetector(
        /// Handles the tap event on the category card.
        /// Navigates to the DrugByCategoryScreen with the selected category's ID and name.
        onTap: () {
          Get.to(() => DrugByCategoryScreen(
                categoryId: category.id,
                categoryName: category.name,
              ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            /// Applies a box shadow to give the card a  3D effect.
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                blurRadius: 8,
                spreadRadius: -8,
                offset: const Offset(0, 4),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              /// Displays the category name.
              category.name,
              style: customLightTheme.textTheme.labelMedium?.copyWith(
                color: kBrand800,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
