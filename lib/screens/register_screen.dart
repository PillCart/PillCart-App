// ignore_for_file: must_be_immutable

/// This file defines the RegisterScreen widget, which is responsible for rendering the user registration interface.
/// It includes form fields for user input, such as first name, last name, phone number, and password,
/// and a button to submit the registration form. The screen also supports language switching.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pill_cart/controller/register_user_controller.dart';
import 'package:pill_cart/utils/theme.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/localization/local_controller.dart';
import 'package:pill_cart/widgets/buttons/custom_primary_button.dart';
import 'package:pill_cart/widgets/text_fields/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  RegisterUserController registerUserController = Get.put(RegisterUserController(), permanent: true);

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.find();
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
              title: Text("Register.".tr),
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<RegisterUserController>(
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
                          'Create your new account'.tr,
                          style: customLightTheme.textTheme.displayMedium?.copyWith(
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Hi doctor, Please enter your details to start makeing some orders.".tr,
                          style: customLightTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black.withOpacity(0.7),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        width > 350
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      keyboardType: TextInputType.name,
                                      isScure: false,
                                      textController: controller.firstNameController,
                                      label: 'First Name'.tr,
                                      isSuffix: false,
                                      preIcon: null,
                                      validateMessage: 'Enter your first name'.tr,
                                      isPrefix: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      keyboardType: TextInputType.name,
                                      isScure: false,
                                      textController: controller.lastNameController,
                                      label: 'Last Name'.tr,
                                      isSuffix: false,
                                      preIcon: null,
                                      validateMessage: 'Enter your last name'.tr,
                                      isPrefix: false,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    isScure: false,
                                    textController: controller.firstNameController,
                                    label: 'First Name'.tr,
                                    isSuffix: false,
                                    preIcon: null,
                                    validateMessage: 'Enter your first name'.tr,
                                    isPrefix: false,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    isScure: false,
                                    textController: controller.lastNameController,
                                    label: 'Last Name'.tr,
                                    isSuffix: false,
                                    preIcon: null,
                                    validateMessage: 'Enter your last name'.tr,
                                    isPrefix: false,
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 16,
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
                            'Register'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              controller.registerUser();
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
                                  Text("Already a member?".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offNamed('/login');
                                    },
                                    child: Text(
                                      "Login.".tr,
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
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already a member?".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: customLightTheme.textTheme.bodySmall),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offNamed('/login');
                                      },
                                      child: Text(
                                        "Login.".tr,
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
                              )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
