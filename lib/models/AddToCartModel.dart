// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

List<AddToCartModel> addToCartModelFromJson(String str) => List<AddToCartModel>.from(json.decode(str).map((x) => AddToCartModel.fromJson(x)));

String addToCartModelToJson(List<AddToCartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddToCartModel {
    int productId;
    int amount;

    AddToCartModel({
        required this.productId,
        required this.amount,
    });

    factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        productId: json["product_id"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "amount": amount,
    };
}
