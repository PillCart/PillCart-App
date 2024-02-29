// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pill_cart/models/user_model.dart';
import 'package:pill_cart/utils/api_endpoints.dart';
import 'package:pill_cart/widgets/custom_snackbar.dart';
import 'package:pill_cart/widgets/custom_loader.dart';

class RegisterUserController extends GetxController {
  late bool isScure;

  User? user;
  late TextEditingController firstNameController, lastNameController, phoneNumberController, passwordController;

  @override
  void onInit() {
    super.onInit();
    isScure = true;
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    isScure = true;
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    passwordController.clear();
  }

  visiblPassword() {
    isScure = !isScure;
    update();
  }

  getUserInfo() async {
    try {
      if (storage.read('token') != null) {
        var token = GetStorage().read('token');
        var resopnse = await http.get(
          Uri.parse(baseUrl + 'userInfo'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        user = userFromJson(resopnse.body);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  registerUser() async {
    try {
      Loader.showLoading();
      var resopnse = await http.post(
        Uri.parse(baseUrl + 'register/user'),
        body: {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text,
          'tokenDevice': 'unknown',
        },
      );
      if (resopnse.statusCode == 200) {
        var data = await jsonDecode(resopnse.body);
        var token = data['token'];
        storage.write('token', token);
        getUserInfo();
        firstNameController.clear();
        lastNameController.clear();
        phoneNumberController.clear();
        passwordController.clear();
        Loader.hideLoading();
        customSnackbar("success", "Registeration completed!", "success", 1500, Colors.green[400]?.withOpacity(0.7));
        Get.offAllNamed("/dash");
      } else {
        Loader.hideLoading();
        customSnackbar("Failed!", "The phone number has already been taken.", "error", 1500, Colors.green[400]?.withOpacity(0.7));
      }
    } catch (e) {
      print(e);
    }
  }

  logoutUser() async {
    try {
      Loader.showLoading();
      await http.post(
        Uri.parse(baseUrl + 'logout'),
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );
      storage.remove('token');
      firstNameController.clear();
      lastNameController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      customSnackbar("success", "Logged out", "success", 1500, Colors.green[400]?.withOpacity(0.7));
      Loader.hideLoading();
      Get.offAllNamed("/register_user");
    } catch (e) {
     print(e);
    }
  }
}
