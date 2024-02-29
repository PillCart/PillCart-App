/// This file contains the definition for the `CompanyTile` widget.
/// This widget is used to display a company tile in the application's UI.
/// It takes a `Categories` object as input and displays the company's name
/// along with an icon. When tapped, it navigates to the `DrugByCompanyScreen`
/// for the selected company.

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/categories_model.dart';
import 'package:pill_cart/screens/drug_by_company_screen.dart';
import 'package:pill_cart/utils/theme.dart';

/// A stateless widget that displays a company tile.
///
/// This widget is designed to be used in a list of companies, displaying
/// the company's name and an icon. When tapped, it navigates to the
/// `DrugByCompanyScreen` for the selected company.
class CompanyTile extends StatelessWidget {
  /// The company to be displayed.
  final Categories company;

  /// Creates a new `CompanyTile` widget.
  ///
  /// @param company The company to be displayed.
  const CompanyTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DrugByCompanyScreen(
              companyId: company.id,
              companyName: company.name,
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
              offset: const Offset(0,  4),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  16, vertical:  12),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.industry,
                size:  12,
                color: kBrand800,
              ),
              const SizedBox(
                width:  8,
              ),
              Expanded(
                child: Text(
                  company.name,
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