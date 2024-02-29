// To parse this JSON data, do
//
//     final detailsForOrderModel = detailsForOrderModelFromJson(jsonString);

import 'dart:convert';

DetailsForOrderModel detailsForOrderModelFromJson(String str) => DetailsForOrderModel.fromJson(json.decode(str));

String detailsForOrderModelToJson(DetailsForOrderModel data) => json.encode(data.toJson());

class DetailsForOrderModel {
  List<DetailsForOrder> detailsForOrder;

  DetailsForOrderModel({
    required this.detailsForOrder,
  });

  factory DetailsForOrderModel.fromJson(Map<String, dynamic> json) => DetailsForOrderModel(
        detailsForOrder: List<DetailsForOrder>.from(json["detailsForOrder"].map((x) => DetailsForOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detailsForOrder": List<dynamic>.from(detailsForOrder.map((x) => x.toJson())),
      };
}

class DetailsForOrder {
  String tradeName;
  int price;
  int amount;
  int id;

  DetailsForOrder({
    required this.tradeName,
    required this.price,
    required this.amount,
    required this.id,
  });

  factory DetailsForOrder.fromJson(Map<String, dynamic> json) => DetailsForOrder(
        tradeName: json["tradeName"],
        price: json["price"],
        amount: json["amount"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "tradeName": tradeName,
        "price": price,
        "amount": amount,
        "id": id,
      };
}
