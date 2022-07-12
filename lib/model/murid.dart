// To parse this JSON data, do
//
//     final murid = muridFromJson(jsonString);

import 'dart:convert';

List<Murid> muridFromJson(String str) => List<Murid>.from(json.decode(str).map((x) => Murid.fromJson(x)));

String muridToJson(List<Murid> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Murid {
    Murid({
        required this.id,
        required this.itemCode,
        required this.itemName,
        required this.price,
        required this.stock,
    });

    String id;
    String itemCode;
    String itemName;
    String price;
    String stock;

    factory Murid.fromJson(Map<String, dynamic> json) => Murid(
        id: json["id"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        price: json["price"],
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_code": itemCode,
        "item_name": itemName,
        "price": price,
        "stock": stock,
    };
}
