// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/search_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/widgets/cards/custom_drug_card.dart';
import 'package:pill_cart/widgets/text_fields/custom_search_bar.dart';

/// SearchResultsScreen is a stateless widget that displays search results.
///
/// This screen is responsible for showing the results of a search query performed by the user.
/// It includes a search bar at the top for the user to input their search query and a list
/// of results displayed below. The results are fetched and managed by the
/// CustomSearchController.
class SearchResultsScreen extends StatelessWidget {
  /// List of search results.
  List<Medicines> searchResults = [];

  /// TextEditingController for the search bar.
  TextEditingController searchController = TextEditingController();

  /// CustomSearchController instance for managing search results.
  CustomSearchController customSearchController = Get.find();

  /// Constructor for SearchResultsScreen.
  SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    searchResults = customSearchController.searchResults;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        //endDrawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
            child: AppBar(
              actionsIconTheme: const IconThemeData(
                size: 32,
                color: kBrand800,
              ),
              foregroundColor: kBrand800,
              title: Text(
                'Search Results'.tr,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              CustomSearchBar(
                onTapOutside: (p0) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                isScure: true,
                textController: searchController,
                isSuffix: true,
                preIcon: FontAwesomeIcons.magnifyingGlass,
                isPrefix: true,
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<CustomSearchController>(builder: (controller) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: !customSearchController.isSearchResultsEmpty.value
                            ? SizedBox(
                                height: 400,
                                child: customSearchController.isSearchResultsLoading.value == true
                                    ? const Center(child: CircularProgressIndicator())
                                    : ListView.separated(
                                        physics: const BouncingScrollPhysics(
                                          decelerationRate: ScrollDecelerationRate.fast,
                                        ),
                                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        separatorBuilder: (context, index) => const SizedBox(
                                          height: 8,
                                        ),
                                        itemCount: customSearchController.searchResults.length,
                                        itemBuilder: (context, index) {
                                          return CustomDrugCard(
                                            medicin: customSearchController.searchResults[index],
                                          );
                                        },
                                      ),
                              )
                            : Center(
                                child: Text('no results'.tr),
                              ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/* */