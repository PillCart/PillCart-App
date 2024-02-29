// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

List<SearchResult> searchResultFromJson(String str) => List<SearchResult>.from(json.decode(str).map((x) => SearchResult.fromJson(x)));

String searchResultToJson(List<SearchResult> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResult {
    int id;
    String tradeName;
    int genericNameId;
    int categoryId;
    int companyId;
    int price;
    int amount;
    int expiringYear;
    int expiringMonth;
    DateTime createdAt;
    DateTime updatedAt;

    SearchResult({
        required this.id,
        required this.tradeName,
        required this.genericNameId,
        required this.categoryId,
        required this.companyId,
        required this.price,
        required this.amount,
        required this.expiringYear,
        required this.expiringMonth,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["id"],
        tradeName: json["tradeName"],
        genericNameId: json["generic_name_id"],
        categoryId: json["category_id"],
        companyId: json["company_id"],
        price: json["price"],
        amount: json["amount"],
        expiringYear: json["expiringYear"],
        expiringMonth: json["expiringMonth"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tradeName": tradeName,
        "generic_name_id": genericNameId,
        "category_id": categoryId,
        "company_id": companyId,
        "price": price,
        "amount": amount,
        "expiringYear": expiringYear,
        "expiringMonth": expiringMonth,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
