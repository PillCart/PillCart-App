// ignore_for_file: unnecessary_string_escapes

/// This file defines the LoginScreen widget, which is responsible for rendering the user login interface.
/// It includes form fields for user input, such as phone number and password,
/// and a button to submit the login form. The screen also supports language switching.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/login_controller.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/localization/local_controller.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/widgets/text_fields/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController(), permanent: true);

  LocalController localController = Get.find();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8, start: 0),
            child: AppBar(
              actions: [
                IconButton(
                  onPressed: localController.isEnglish
                      ? () {
                          localController.changeLang('ar');
                        }
                      : () {
                          localController.changeLang('en');
                        },
                  icon: const Icon(Icons.language),
                ),
              ],
              actionsIconTheme: const IconThemeData(
                size: 32,
                color: kBrand800,
              ),
              foregroundColor: kBrand800,
              title: Text(
                'Login'.tr,
              ),
            ),
          ),
        ),
        body: GetBuilder<LoginController>(
          builder: (controller) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.15,
                      ),
                      Text(
                        "Welcome back".tr,
                        style: customLightTheme.textTheme.displayMedium?.copyWith(
                          color: Colors.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Of course you didn't forget your account information, doctor!".tr,
                        style: customLightTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.phone,
                        isScure: false,
                        textController: controller.phoneNumberController,
                        label: 'Phone Number'.tr,
                        isSuffix: false,
                        preIcon: FontAwesomeIcons.phone,
                        validateMessage: 'Enter your phone number'.tr,
                        isPrefix: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        controller: controller,
                        isScure: true,
                        textController: controller.passwordController,
                        label: 'Password'.tr,
                        isSuffix: true,
                        preIcon: FontAwesomeIcons.lock,
                        validateMessage: 'Enter a strong password'.tr,
                        isPrefix: true,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CPrimaryButton(
                        isEnabled: true,
                        color: kBrand600,
                        buttonText: Text(
                          'Login'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      width > 300
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don\'t have an account?".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                                const SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed('/register_user');
                                  },
                                  child: Text("Register.".tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: customLightTheme.textTheme.bodySmall?.copyWith(
                                        color: kBrand800,
                                        fontFamily: 'Lexend_Bold',
                                        decoration: TextDecoration.underline,
                                      )),
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Don\'t have an account?".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offNamed('/register_user');
                                    },
                                    child: Text(
                                      "Register.".tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: customLightTheme.textTheme.bodySmall?.copyWith(
                                        color: kBrand800,
                                        fontFamily: 'Lexend_Bold',
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
