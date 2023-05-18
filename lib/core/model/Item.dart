
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Items> itemFromJson(String str) => List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemToJson(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  Items({
    this.id,
    this.idClient,
    this.idCeatedStaff,
    this.idDeletedStaff,
    this.itemCode,
    this.description,
    this.barcode,
    this.articleNum,
    this.uom,
    this.deleted,
    this.status,
    this.dateCreated,
    this.dateDeleted,
    this.quantity='0',
    this.unitPrice,
    this.category='',
    this.selected=false,
    this.image,
    this.color,
    this.size=50,
    this.imageUrl,
    this.qtyInStock,
    this.qtyCounted,
    this.id_stock_count,

  });

  String id;
  String idClient;
  final dynamic idCeatedStaff;
  final dynamic idDeletedStaff;
  String itemCode;
  String description;
  String barcode;
  dynamic articleNum;
  String uom;
  final String deleted;
  dynamic status;
  final DateTime dateCreated;
  final DateTime dateDeleted;
  String quantity;
  double unitPrice;
  String category;
  String imageUrl;
  bool selected;
  String image;
  double size;
  Color color;
  String qtyInStock;
  String qtyCounted;
  String id_stock_count;



  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    idClient: json["id_client"],
    idCeatedStaff: json["id_ceated_staff"],
    idDeletedStaff: json["id_deleted_staff"],
    itemCode: json["item_code"],
    description: json["description"],
    barcode: json["barcode"],
    articleNum: json["article_num"],
    uom: json["uom"],
    deleted: json["deleted"],
    status: json["status"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateDeleted: DateTime.parse(json["date_deleted"]),
    // quantity: int.parse(json["quantity"]),
    quantity: '0',
    unitPrice: double.parse(json["UnitPrice"]),
    category: json["category"],
    imageUrl: json["imageUrl"],
    qtyInStock : json['qtyInStock'],
    qtyCounted : json['qtyCounted'] == null ? '0' : json['qtyCounted'],
    id_stock_count: json['id_stock_count'] == null ? '0' : json['id_stock_count'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "id_ceated_staff": idCeatedStaff,
    "id_deleted_staff": idDeletedStaff,
    "item_code": itemCode,
    "description": description,
    "barcode": barcode,
    "article_num": articleNum,
    "uom": uom,
    "deleted": deleted,
    "status": status,
    "date_created": dateCreated.toIso8601String(),
    "date_deleted": dateDeleted.toIso8601String(),
    "quantity": quantity.toString(),
    "UnitPrice": unitPrice.toString(),
    "category": category,
    "imageUrl":imageUrl,
    "qtyInStock" : qtyInStock,
    "qtyCounted" : qtyCounted,
    "id_stock_count" : id_stock_count,
  };





  String getIndex(int index) {
    switch (index) {
      case 0:
        return description;
      case 1:
        return uom;
      case 2:
        return unitPrice.toString();

    }
    return '';
  }
}




