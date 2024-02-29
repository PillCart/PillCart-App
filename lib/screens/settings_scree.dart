// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/register_user_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/localization/local_controller.dart';
import 'package:pill_cart/widgets/buttons/custom_outline_button.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';

class SettingsScreen extends StatelessWidget {
  RegisterUserController registerUserController = Get.put(RegisterUserController());
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(
            size: 32,
            color: kBrand800,
          ),
          foregroundColor: kBrand800,
          title: Text('settings'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('change language'.tr),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CPrimaryButton(
                          isEnabled: localController.isEnglish ? false : true,
                          buttonText: Text('English'.tr),
                          onPressed: () {
                            localController.changeLang('en');
                          },
                          color: kBrand600),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CPrimaryButton(
                          isEnabled: localController.isEnglish ? true : false,
                          buttonText: Text('Arabic'.tr),
                          onPressed: () {
                            localController.changeLang('ar');
                          },
                          color: kBrand600),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              COutlineButton(
                  buttonText: "Logout".tr,
                  onPressed: () {
                    registerUserController.logoutUser();
                  },
                  color: red),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
