import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  bool isEnglish = true;

  void changeLang(String langCode) {
    if (langCode == 'ar') {
      isEnglish = false;
      Locale locale = Locale(langCode);
      Get.updateLocale(locale);
      update();
    } else {
      isEnglish = true;
      Locale locale = Locale(langCode);
      Get.updateLocale(locale);
      update();
    }
  }
}
