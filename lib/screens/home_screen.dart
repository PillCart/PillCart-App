// ignore_for_file: must_be_immutable

/// This file defines the HomeScreen widget, which is the main screen of the PillCart application.
/// It displays a list of recent categories, companies, and in-stock items.
/// Users can search for items, view more categories or companies, and see more in-stock items.
/// The screen also includes a refresh indicator to update the displayed data.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/home_screen_controller.dart';
import 'package:pill_cart/controller/search_controller.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/localization/local_controller.dart';
import 'package:pill_cart/widgets/cards/custom_drug_card.dart';
import 'package:pill_cart/widgets/cards/custom_category_card.dart';
import 'package:pill_cart/widgets/cards/custom_company_card.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';
import 'package:pill_cart/widgets/text_fields/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  HomeScreenController homeScreenController = Get.find();
  CustomSearchController customSearchController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 0, start: 0),
            child: AppBar(
              centerTitle: true,
              actionsIconTheme: const IconThemeData(
                size: 32,
                color: kBrand800,
              ),
              foregroundColor: kBrand800,
              title: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/app_logo.png'),
                    height: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'PillCart',
                    style: TextStyle(color: kBrand500),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
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
                GetBuilder<HomeScreenController>(
                  builder: (controller) {
                    return Expanded(
                      child: RefreshIndicator(
                        backgroundColor: kBrand600.withOpacity(0.3),
                        color: Colors.white,
                        onRefresh: () async {
                          await homeScreenController.getAllCategory();
                          await homeScreenController.getAllCompanies();
                          await homeScreenController.getAlldrugs();
                        },
                        child: Column(
                          children: [
                            //? ----------------categoris----------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Recent Categories".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelLarge?.copyWith(
                                      color: kBrand800,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    homeScreenController.onReady();
                                    Get.toNamed('/categories');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'see more'.tr,
                                        style: customLightTheme.textTheme.labelSmall?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        localController.isEnglish ? FontAwesomeIcons.angleRight : FontAwesomeIcons.angleLeft,
                                        size: 18,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                              child:
                                  //testBool
                                  homeScreenController.isCategoriesAndCompaniesLoading.value == true
                                      ? Center(
                                          child: SizedBox(
                                            width: width * 0.5,
                                            child: const CustomLinearProgressIndicator(),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: ListView.builder(
                                            physics: const BouncingScrollPhysics(
                                              decelerationRate: ScrollDecelerationRate.fast,
                                            ),
                                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: homeScreenController.categories.length ~/ 2,
                                            itemBuilder: (context, index) {
                                              return CategoryCard(
                                                category: homeScreenController.categories[index],
                                              );
                                            },
                                          ),
                                        ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            //? ----------------company----------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Recent Companies".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelLarge?.copyWith(
                                      color: kBrand800,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    homeScreenController.onReady();
                                    Get.toNamed('/companies');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'see more'.tr,
                                        style: customLightTheme.textTheme.labelSmall?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        localController.isEnglish ? FontAwesomeIcons.angleRight : FontAwesomeIcons.angleLeft,
                                        size: 18,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                              child:
                                  //testBool
                                  homeScreenController.isCategoriesAndCompaniesLoading.value == true
                                      ? Center(
                                          child: SizedBox(
                                            width: width * 0.5,
                                            child: const CustomLinearProgressIndicator(),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: ListView.builder(
                                            physics: const BouncingScrollPhysics(
                                              decelerationRate: ScrollDecelerationRate.fast,
                                            ),
                                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: homeScreenController.companies.length ~/ 2,
                                            itemBuilder: (context, index) {
                                              return CompanyCard(
                                                company: homeScreenController.companies[index],
                                                //cardForTest
                                              );
                                            },
                                          ),
                                        ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            //? ----------------in stock----------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Recent In Stock".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: customLightTheme.textTheme.labelLarge?.copyWith(
                                      color: kBrand800,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // homeScreenController.onClose();
                                    Get.toNamed('all_drugs');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'see more'.tr,
                                        style: customLightTheme.textTheme.labelSmall?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        localController.isEnglish ? FontAwesomeIcons.angleRight : FontAwesomeIcons.angleLeft,
                                        size: 18,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: homeScreenController.isCategoriesAndCompaniesLoading.value == true
                                  ? const Center(child: CustomCircularProgressIndicator())
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(
                                          decelerationRate: ScrollDecelerationRate.fast,
                                        ),
                                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        separatorBuilder: (context, index) => const SizedBox(
                                          height: 8,
                                        ),
                                        itemCount: 10,
                                        // homeScreenController.medicines.length,
                                        itemBuilder: (context, index) {
                                          return CustomDrugCard(
                                            medicin: homeScreenController.medicines[homeScreenController.medicines.length - index - 1],
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
