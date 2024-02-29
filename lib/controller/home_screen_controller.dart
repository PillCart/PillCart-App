// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pill_cart/controller/cart_controller.dart';
import 'package:pill_cart/models/categories_model.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/utils/api_endpoints.dart';

class HomeScreenController extends GetxController {
  CartController cartController = Get.put(CartController(), permanent: false);
  int tabIndex = 0;

  List<Medicines> medicines = [];
  List<Categories> categories = [];
  List<Categories> companies = [];
  List<Medicines> drugByCategory = [];
  List<Medicines> drugByCompany = [];

  Medicines? medicin;

  RxBool isCategoriesAndCompaniesLoading = true.obs;
  RxBool isDrugLoading = true.obs;
  RxBool isDrugDetailsLoading = true.obs;

  void changeTabIndex(int index) {
    if (index == 2) {
      cartController.ShowMyOrder();
    } else if (index == 0) {
      getAlldrugs();
      getAllCategory();
      getAllCompanies();
    }
    tabIndex = index;
    update();
  }

  getAlldrugs() async {
    try {
      isDrugLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'index'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        medicines = medicinesFromJson(response.body);
        isDrugLoading(false);
        update();
      } else {
      }
    } catch (e) {
      print(e);
    }
  }

  getAllCategory() async {
    try {
      isCategoriesAndCompaniesLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'category'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        categories = categoriesFromJson(response.body);
        isCategoriesAndCompaniesLoading(false);
        update();
      } else {
      }
      isCategoriesAndCompaniesLoading(false);
    } catch (e) {
      print(e);
    }
  }

  getAllCompanies() async {
    try {
      isCategoriesAndCompaniesLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'company'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        companies = categoriesFromJson(response.body);
        isCategoriesAndCompaniesLoading(false);
        update();
      } else {
      }
      isCategoriesAndCompaniesLoading(false);
    } catch (e) {
      print(e);
    }
  }

  getAllDrugsByCategory(int id) async {
    try {
      isDrugLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'productsOfCategory/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data.toString() == "{" "message" ":" " No products found" "}") {
          drugByCategory = [];
          isDrugLoading(false);
          update();
        } else {
          drugByCategory = medicinesFromJson(response.body);
          isDrugLoading(false);
          update();
        }
      } else {
      }
      isDrugLoading.value = false;
    } catch (e) {
      print(e);
    } finally {
      isDrugLoading(false);
    }
  }

  getAllDrugsByCompany(int id) async {
    try {
      isDrugLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'productsOfCompany/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data.toString() == "{" "message" ":" " No products found" "}") {
          drugByCategory = [];
          isDrugLoading(false);
          update();
        } else {
          drugByCompany = medicinesFromJson(response.body);
          isDrugLoading(false);
          update();
        }
      } else {
      }
      isDrugLoading.value = false;
    } catch (e) {
      print(e);
    } finally {
      isDrugLoading(false);
    }
  }

  getDrugDetails(int id) async {
    try {
      isDrugDetailsLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'find/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        medicin = Medicines.fromJson(data);
        isDrugDetailsLoading(false);
        update();
      } else {
      }
      isDrugDetailsLoading(false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() async {
    medicines = [];
    categories = [];
    companies = [];
    super.onClose();
  }

  @override
  void onReady() async {
    cartController.ShowMyOrder();
    getAlldrugs();
    await getAllCategory();
    await getAllCompanies();
    update();
  }
}
