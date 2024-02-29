// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pill_cart/models/AddToCartModel.dart';
import 'package:pill_cart/models/MyOrderModel.dart';
import 'package:pill_cart/models/detailsForOrderModel.dart';
import 'package:pill_cart/models/medicines_model.dart';
import 'package:pill_cart/utils/api_endpoints.dart';
import 'package:pill_cart/widgets/custom_loader.dart';
import 'package:pill_cart/widgets/custom_snackbar.dart';

class CartController extends GetxController {
  RxBool isOrdersLoading = true.obs;
  RxBool isOrderDetailesLoading = true.obs;
  RxBool isMyOrdersEmpty = true.obs;
  RxBool isCartEmpty = true.obs;
  RxBool isOrdering = true.obs;

  List<Medicines> medicinsInCart = [];
  List<int> amount = [];
  List<int> inCart = [];

  Map<int, int> medInCart = {};

  Order? myOrders;
  DetailsForOrderModel? detailsOrder;

  @override
  void onReady() {
    ShowMyOrder();
    super.onReady();
  }

  List<int> ids = [];

  void updateCart() {
    update();
  }

  void AddToCart(Medicines element, int quantity, int id) async {
    medicinsInCart.add(element);
    amount.add(quantity);
    inCart.add(id);
    isCartEmpty(false);
  }

  deleteFromCart(Medicines element, int id, int quantity) {
    inCart.remove(id);
    medicinsInCart.remove(element);
    amount.remove(quantity);
    if (inCart.isEmpty) {
      isCartEmpty(true);
    }
    update();
  }

  Map<String, dynamic> data = {};
  List<Map<dynamic, dynamic>> myMap = [];
  List<AddToCartModel> CartModel = [];

  Future<void> cleanCart() async {
    inCart = [];
    medicinsInCart = [];
    amount = [];
    CartModel = [];
  }

  SendOrder() async {
    isOrdering(true);
    AddToCartModel cart;
    for (int i = 0; i < inCart.length; i++) {
      cart = AddToCartModel(productId: medicinsInCart[i].id, amount: amount[i]);
      CartModel.add(cart);
    }
    try {
      Loader.showLoading();
      String jsonData = jsonEncode(CartModel);
      http.Response response = await http.post(
        Uri.parse(baseUrl + 'createOrder'),
        body: jsonData,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          'Lan_Token': 'ar',
        },
      );
      if (response.statusCode == 200) {
        isOrdering(true);
        Loader.hideLoading();
        customSnackbar("orderSnack".tr, 'orderSnackM'.tr, 'done', 1300, Colors.green[400]?.withOpacity(0.7));
      } else {}
    } catch (e) {
      print(e);
    }
  }

  deleteOrder(int orderId) async {
    try {
      await http.delete(Uri.parse(baseUrl + 'deleteOrder/$orderId'), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $userToken', 'Lan_Token': 'ar'});
    } catch (e) {
      print(e);
    }
  }

  ShowMyOrder() async {
    try {
      isOrdersLoading(true);
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'myOrders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          'Lan_Token': 'ar',
        },
      );
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonData['message'] == 'you dont have any order') {
          isOrdersLoading(false);
          isMyOrdersEmpty(true);
          update();
        } else {
          myOrders = myOrderFromJson(response.body);
          isOrdersLoading(false);
          isMyOrdersEmpty(false);
          update();
        }
      }
      isOrdersLoading(false);
    } catch (e) {
      print(e);
    }
  }

  ShowdetailesOfOrder(int id) async {
    try {
      isOrderDetailesLoading(true);
      http.Response response = await http.get(Uri.parse(baseUrl + 'detailsForOrder/$id'), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $userToken', 'Lan_Token': 'ar'});
      if (response.statusCode == 200) {
        detailsOrder = detailsForOrderModelFromJson(response.body);
        isOrderDetailesLoading(false);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
