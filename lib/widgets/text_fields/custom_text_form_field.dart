// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_types_as_parameter_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

/// This file contains the definition for the `CustomTextField` widget.
/// This widget is a custom implementation of a text form field, designed to
/// provide a consistent look and feel across the application. It supports various
/// configurations such as prefix/suffix icons, secure text input, and custom
/// validation messages.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/utils/theme.dart';

/// A stateless widget that displays a custom text form field.
///
/// This widget is designed to be highly customizable, allowing for various
/// configurations such as prefix/suffix icons, secure text input, and custom
/// validation messages. It also supports different keyboard types and custom
/// styling for the text and labels.
class CustomTextField extends StatelessWidget {
  var controller;
  String validateMessage;
  TextEditingController textController;
  bool isSuffix;
  bool isPrefix;
  IconData? preIcon;
  bool isScure;
  TextInputType keyboardType;
  String label;

  /// Creates a new `CustomTextField` widget.
  ///
  /// @param controller The controller for the text field.
  /// @param validateMessage The validation message to be displayed when the input is invalid.
  /// @param textController The text editing controller for the text field.
  /// @param isSuffix Whether the text field should display a suffix icon.
  /// @param isPrefix Whether the text field should display a prefix icon.
  /// @param preIcon The icon to be displayed as a prefix.
  /// @param isScure Whether the text field should obscure the text (useful for password fields).
  /// @param keyboardType The keyboard type for the text field.
  /// @param label The label text for the text field
  CustomTextField({
    super.key,
    this.controller,
    required this.validateMessage,
    required this.textController,
    required this.isSuffix,
    required this.isPrefix,
    required this.preIcon,
    required this.isScure,
    required this.label,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: customLightTheme.textTheme.bodySmall?.copyWith(
        color: Colors.black,
      ),
      obscureText: isScure ? controller.isScure : false,
      cursorColor: kBrand800,
      cursorHeight: 24,
      cursorOpacityAnimates: true,
      validator: label == 'Phone Number'
          ? (Value) {
              if (Value == null || Value.isEmpty) {
                return validateMessage;
              } else if (!Value.isNum) {
                return 'The phone number must be numbers only';
              } else if (Value.length < 10) {
                return 'you should enter ten digits, ${10 - Value.length} digit/s remain';
              } else if (Value.length > 10) {
                return 'you should enter ten digits, delete ${Value.length - 10} digit/s';
              }
              return null;
            }
          : (Value) {
              if (Value == null || Value.isEmpty) {
                return validateMessage;
              }
              return null;
            },
      controller: textController,
      decoration: InputDecoration(
        contentPadding: isPrefix ? const EdgeInsets.symmetric(horizontal: 16, vertical: 0) : const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
        suffixIcon: isSuffix
            ? IconButton(
                splashRadius: 1,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {
                  controller.visiblPassword();
                },
                icon: controller.isScure
                    ? const Icon(
                        FontAwesomeIcons.solidEye,
                      )
                    : const Icon(FontAwesomeIcons.solidEyeSlash),
                focusColor: kBrand200,
                color: kBrand800,
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        labelStyle: customLightTheme.textTheme.labelSmall?.copyWith(
          color: kBrand800,
        ),
        filled: true,
        fillColor: Colors.grey[100],
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
      ),
    );
  }
}
