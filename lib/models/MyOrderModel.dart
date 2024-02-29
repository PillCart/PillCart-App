// To parse this JSON data, do
//
//     final myOrder = myOrderFromJson(jsonString);

import 'dart:convert';

Order myOrderFromJson(String str) => Order.fromJson(json.decode(str));

String myOrderToJson(Order data) => json.encode(data.toJson());

class Order {
  List<MyOrderElement> myOrders;

  Order({
    required this.myOrders,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        myOrders: List<MyOrderElement>.from(json["Orders"].map((x) => MyOrderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Orders": List<dynamic>.from(myOrders.map((x) => x.toJson())),
      };
}

class MyOrderElement {
  int id;
  int userId;
  int totalPrice;
  int year;
  int month;
  int day;
  String deliveryStatus;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;

  MyOrderElement({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.year,
    required this.month,
    required this.day,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyOrderElement.fromJson(Map<String, dynamic> json) => MyOrderElement(
        id: json["id"],
        userId: json["user_id"],
        totalPrice: json["totalPrice"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        deliveryStatus: json["deliveryStatus"],
        paymentStatus: json["paymentStatus"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "totalPrice": totalPrice,
        "year": year,
        "month": month,
        "day": day,
        "deliveryStatus": deliveryStatus,
        "paymentStatus": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
