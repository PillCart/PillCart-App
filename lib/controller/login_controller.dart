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

class LoginController extends GetxController {
  late bool isScure;
  User? user;
  late TextEditingController phoneNumberController, passwordController;
  @override
  void onInit() {
    super.onInit();
    isScure = true;
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    isScure = true;
    phoneNumberController.clear();
    passwordController.clear();
  }

  visiblPassword() {
    isScure = !isScure;
    update();
  }

  login() async {
    try {
      Loader.showLoading();
      String? fcmToken = storage.read('fcmToken') ?? 'unknown';

      var resopnse = await http.post(
        Uri.parse(baseUrl + 'login'),
        body: {
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text,
          'tokenDevice': fcmToken,
        },
      );

      if (resopnse.statusCode == 200) {
        var data = await jsonDecode(resopnse.body);
        if (data['message'] == "Wrong password") {
          Loader.hideLoading();
          customSnackbar("Failed!", "Wrong password", "error", 300, Colors.green[400]?.withOpacity(0.7));
        } else if (data['message'] == "Wrong phone number") {
          Loader.hideLoading();
          customSnackbar("Failed!", "Wrong phone number", "error", 300, Colors.green[400]?.withOpacity(0.7));
        } else {
          var token = data['token'];
          var storage = GetStorage();
          storage.write('token', token);
          Loader.hideLoading();
          customSnackbar("success", "Logged in!", "success", 300, Colors.green[400]?.withOpacity(0.7));
          Get.offAllNamed("/dash");
        }
      } else {
        Loader.hideLoading();

        customSnackbar("Ex", "Ex", "error", 300, Colors.green[400]?.withOpacity(0.7));
      }
    } catch (e) {
      print(e);
    }
  }
}
