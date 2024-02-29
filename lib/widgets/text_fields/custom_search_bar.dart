// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_types_as_parameter_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/search_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/utils/theme.dart';

/// A custom search bar widget that integrates with the GetX state management solution.
/// This widget is designed to provide a search functionality with customizable
/// features such as prefix/suffix icons, secure text input, and custom styling.
class CustomSearchBar extends StatelessWidget {
  // Instance of the CustomSearchController to handle search logic.
  CustomSearchController customSearchController = Get.put(CustomSearchController());

  // Controller for the text field to manage its state.
  TextEditingController? textController;

  // Flags to determine if the search bar should display a prefix or suffix icon.
  bool isSuffix;
  bool isPrefix;

  // Icon data for the prefix icon.
  IconData? preIcon;

  // Flag to determine if the text field should obscure text (e.g., for password fields).
  bool isScure;

  // Callback function to handle tap events outside the search bar.
  Function(PointerDownEvent) onTapOutside;

  // Callback function to handle text changes in the search bar.
  Function(String)? onChanged;

  /// Constructor for the CustomSearchBar widget.
  ///
  /// @param textController: The controller for the text field.
  /// @param isSuffix: Flag to indicate if a suffix icon should be displayed.
  /// @param isPrefix: Flag to indicate if a prefix icon should be displayed.
  /// @param preIcon: Icon data for the prefix icon.
  /// @param isScure: Flag to indicate if the text field should obscure text.
  /// @param onTapOutside: Callback function for tap events outside the search bar.
  /// @param onChanged: Callback function for text changes in the search bar.
  CustomSearchBar({
    super.key,
    required this.textController,
    required this.isSuffix,
    required this.isPrefix,
    required this.preIcon,
    required this.isScure,
    required this.onTapOutside,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: -8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        // Handles the submission of the search query.
        onFieldSubmitted: (Value) {
          customSearchController.search(Value);
          Get.toNamed('/search_result');
          textController!.clear();
        },
        // Handles text changes in the search bar.
        onChanged: (value) {
          customSearchController.search(value);
        },
        // Handles tap events outside the search bar.
        onTapOutside: onTapOutside,
        style: customLightTheme.textTheme.bodySmall?.copyWith(
          color: Colors.black,
          height: 1.4,
        ),
        obscureText: false,
        cursorColor: kBrand800,
        cursorHeight: 24,
        cursorOpacityAnimates: true,
        controller: textController,
        decoration: InputDecoration(
          hoverColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: isPrefix
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      preIcon,
                      size: 24,
                      color: kBrand800,
                    ),
                  ),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: 'Search'.tr,
          hintStyle: customLightTheme.textTheme.labelMedium?.copyWith(
            color: kBrand800,
          ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: customLightTheme.textTheme.labelSmall?.copyWith(
            color: red,
            height: 1,
          ),
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: kBrand800,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }
}
