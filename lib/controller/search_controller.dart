// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unnecessary_null_comparison

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/utils/api_endpoints.dart';

class CustomSearchController extends GetxController {
  RxBool isSearchResultsLoading = true.obs;
  RxBool isSearchResultsEmpty = false.obs;
  List<Medicines> searchResults = [];

  search(String key) async {
    if (key != null) {
      try {
        isSearchResultsLoading(true);
        http.Response response = await http.get(
          Uri.parse(baseUrl + 'search/$key'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken',
          },
        );
        var data = jsonDecode(response.body);
        if (data[0] == null) {
          isSearchResultsLoading(false);
          isSearchResultsEmpty(true);
          update();
        }
        searchResults = medicinesFromJson(response.body);
        isSearchResultsEmpty(false);
        isSearchResultsLoading(false);
        update();
        if (response.statusCode == 200) {
        } else {
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
