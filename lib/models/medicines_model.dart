// To parse this JSON data, do
//
//  final medicines = medicinesFromJson(jsonString);

import 'dart:convert';

List<Medicines> medicinesFromJson(String str) => List<Medicines>.from(json.decode(str).map((x) => Medicines.fromJson(x)));

String medicinesToJson(List<Medicines> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Medicines {
  final int id;
  final String? tradeName;
  final int genericNameId;
  final int categoryId;
  final int companyId;
  final int price;
  final int amount;
  final int expiringYear;
  final int expiringMonth;
  final int expiringDay;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final Category company;
  final Category genericName;
  final int Show;

  Medicines({
    required this.id,
    required this.tradeName,
    required this.genericNameId,
    required this.categoryId,
    required this.companyId,
    required this.price,
    required this.amount,
    required this.expiringYear,
    required this.expiringMonth,
    required this.expiringDay,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.company,
    required this.genericName,
    required this.Show,
  });

  factory Medicines.fromJson(Map<String, dynamic> json) => Medicines(
        id: json["id"],
        tradeName: json["tradeName"],
        genericNameId: json["generic_name_id"],
        categoryId: json["category_id"],
        companyId: json["company_id"],
        price: json["price"],
        Show: json["Show"],
        amount: json["amount"],
        expiringYear: json["expiringYear"],
        expiringMonth: json["expiringMonth"],
        expiringDay: json["expiringDay"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        company: Category.fromJson(json["company"]),
        genericName: Category.fromJson(json["generic_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tradeName": tradeName,
        "generic_name_id": genericNameId,
        "category_id": categoryId,
        "company_id": companyId,
        "price": price,
        "Show": Show,
        "amount": amount,
        "expiringYear": expiringYear,
        "expiringMonth": expiringMonth,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "company": company.toJson(),
        "generic_name": genericName.toJson(),
      };
}

class Category {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
