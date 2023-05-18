
import 'dart:convert';
///Parse stocktake list json
List<StocktakeCount> stockTakeCountFromJson(String str) => List<StocktakeCount>.from(json.decode(str).map((x) => StocktakeCount.fromJson(x)));

class StocktakeCount
{
  String id ;
  String id_stocktake_task ;
  String id_item ;
  String id_ceated_staff ;
  String id_deleted_staff ;
  String qty;
  String bin_number ;
  String rate_of_sale;
  String status ;
  String deleted ;
  String date_expiry;
  String date_created;
  String date_deleted;
  String description;
  String barcode;
  String uom;
  String id_store_branch;

  StocktakeCount({
    this.id ,
    this.id_stocktake_task ,
    this.id_item ,
    this.id_ceated_staff ,
    this.id_deleted_staff ,
    this.qty,
    this.bin_number ,
    this.rate_of_sale,
    this.status ,
    this.deleted ,
    this.date_expiry,
    this.date_created,
    this.date_deleted,
    this.description,
    this.barcode,
    this.uom,
    this.id_store_branch,
  });


  factory StocktakeCount.fromJson(Map<String, dynamic> json){
    return StocktakeCount(
      id: json['id'] as String,
      id_stocktake_task: json['id_stocktake_task'] as String,
      id_item: json['id_item'] as String,
      id_ceated_staff: json['id_ceated_staff'] as String,
      id_deleted_staff: json['id_deleted_staff'] as String,
      qty: json['qty'] as String,
      bin_number: json['bin_number'] as String,
      rate_of_sale: json['rate_of_sale'] as String,
      status: json['status'] as String,
      deleted: json['deleted'] as String,
      date_expiry: json['date_expiry'] as String,
      date_created: json['date_created'] as String,
      date_deleted: json['date_deleted'] as String,
      description: json['description'] as String,
      barcode: json['barcode'] as String,
      uom: json['uom'] as String,
      id_store_branch: json['id_store_branch'] as String,
    );
  }


}