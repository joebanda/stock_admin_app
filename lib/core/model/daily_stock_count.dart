
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<DailyStockCount> dailyStockCountFromJson(String str) => List<DailyStockCount>.from(json.decode(str).map((x) => DailyStockCount.fromJson(x)));

String dailyStockCountToJson(List<DailyStockCount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyStockCount {
  DailyStockCount({
    this.id,
    this.id_item,
    this.id_counted_by,
    this.id_sales_person,
    this.id_warehouse,
    this.id_deleted_staff,
    this.id_store_branch,
    this.id_client,
    this.qty_on_system,
    this.qty_actual_count,
    this.bin_number,
    this.date_of_count,
    this.date_deleted,
    this.item_name,
    this.item_code,
    this.barcode,
    this.uom,
    this.reference,
    this.batch_no,
    this.status,
    this.deleted,


  });

  String id;
  String id_item;
  String id_counted_by;
  String id_sales_person;
  String id_warehouse;
  String id_deleted_staff;
  String id_store_branch;
  String id_client;
  double qty_on_system;
  double qty_actual_count;
  String bin_number;
  DateTime date_of_count;
  DateTime date_deleted;
  String item_name;
  String item_code;
  String barcode;
  String uom;
  String reference;
  String batch_no;
  String status;
  String deleted;




  factory DailyStockCount.fromJson(Map<String, dynamic> json) => DailyStockCount(
      id: json["id"],
      id_item : json["id_item"],
    id_counted_by: json["id_counted_by"],
    id_sales_person : json["id_sales_person"],
    id_warehouse : json["id_warehouse"],
    id_deleted_staff : json["id_deleted_staff"],
    id_store_branch : json["id_store_branch"],
    id_client : json["id_client"],
    qty_on_system : json["qty_on_system"] == null ? 0.00 : double.parse(json["qty_on_system"]) ,
    qty_actual_count  : json["qty_actual_count"]== null ? 0.00 : double.parse(json["qty_actual_count"]) ,
    bin_number : json["bin_number"],
    date_of_count : DateTime.parse(json["date_of_count"]),
    date_deleted : DateTime.parse(json["date_deleted"]),
    item_name : json["item_name"],
    item_code : json["item_code"],
    barcode : json["barcode"],
    uom : json["uom"],
    reference : json["reference"],
   batch_no : json["batch_no"],
    status : json["status"],
    deleted : json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_item" : id_item,
    "id_counted_by": id_counted_by,
    "id_sales_person" : id_sales_person,
    "id_warehouse" : id_warehouse,
    "id_deleted_staff" : id_deleted_staff,
    "id_store_branch" : id_store_branch,
    "id_client" : id_client,
    "qty_on_system" : qty_on_system,
    "qty_actual_count"  : qty_actual_count,
    "bin_number" : bin_number,
    "date_of_count" : date_of_count.toIso8601String(),
    "date_deleted" : date_deleted.toIso8601String(),
    "item_name" : item_name,
    "item_code" : item_code,
    "barcode" : barcode,
    "uom" : uom,
    "reference" : reference,
    "batch_no" : batch_no,
    "status" : status,
    "deleted" : deleted,


  };



}




