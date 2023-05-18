import 'dart:convert';

import 'package:flutter/src/material/date.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../main.dart';


import '../model/daily_stock_count.dart';

import '../services/Strings.dart';





class DailyStockCountDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/daily_stock_count_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL';





  //get Items
  static Future<List<DailyStockCount>> getItems() async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;


      final response = await http.post(url, body: map);
      print('get all Items in OPA Response: ${response.body}');
      if(200 == response.statusCode){
        List <DailyStockCount> list =  parseResponse(response.body);
        return list;
      }else{
        return List<DailyStockCount>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<DailyStockCount>();//return an empty list on exception/ error
    }
  }

  static List<DailyStockCount> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DailyStockCount>((json) => DailyStockCount.fromJson(json)).toList();

  }

  static Future<String> addCount(DailyStockCount count) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = 'ADD_COUNT';
      map["dbName"] = MyApp.db_name;
      //
      map['id'] = count.id;
     map['id_item'] = count.id_item;
      map['id_counted_by'] = count.id_counted_by;
      map['id_sales_person'] = count.id_sales_person;
      map['id_warehouse'] = count.id_warehouse;
      map['id_deleted_staff'] = count.id_deleted_staff;
      map['id_store_branch'] = count.id_store_branch;
      map['id_client'] = count.id_client;
      map['qty_on_system'] = count.qty_on_system.toString();
     map['qty_actual_count'] = count.qty_actual_count.toString();
      map['bin_number'] = count.bin_number;
      map['item_name'] = count.item_name;
      map['item_code'] = count.item_code;
      map['barcode'] = count.barcode;
      map['uom '] = count.uom;
      map['reference'] = count.reference;
      map['batch_no'] = count.batch_no;
      map['status'] = count.status;


      final response = await http.post(url, body: map);
      print('addCount Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "errorX";
      }
    } catch (e) {
      return "errorX";
    }
  }


  static Future<String> updateCount(String id_stock_count, double qty) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = 'UPDATE_COUNT';
      map["dbName"] = MyApp.db_name;
      //
      map['id'] = id_stock_count;

      map['qty_actual_count'] = qty.toString();



      final response = await http.post(url, body: map);
      print('updateCount Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "errorX";
      }
    } catch (e) {
      return "errorX";
    }
  }


  static Future<List<DailyStockCount>> getStockCountsByDateRange(DateTimeRange dateRange) async {

    try {

      var map = Map<String, dynamic>();
      map['action'] = 'GET_STOCK_COUNTS_BY_DATE_RANGE';
      map["dbName"] = MyApp.db_name;

      map['date_start'] = dateRange.start.toString();
      map['date_end'] = dateRange.end.toString();


      final response = await http.post(url, body: map);
      print('getStockCountsByDateRange Response: ${response.body}');
      if(200 == response.statusCode){
        List <DailyStockCount> list =  parseResponse(response.body);
        return list;
      }else{
        return List<DailyStockCount>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<DailyStockCount>();//return an empty list on exception/ error
    }
  }


  static Future<List<DailyStockCount>>  getStockCountsByUserByDate(String id_sales_person, DateTime date_of_count) async {

    try {

      var map = Map<String, dynamic>();
      map['action'] = 'GET_STOCK_COUNTS_BY_USER_BY_DATE';
      map["dbName"] = MyApp.db_name;

      map['id_sales_person'] = id_sales_person;
      map['date_of_count'] = date_of_count.toString();


      final response = await http.post(url, body: map);
      print('getStockCountsByUserByDate Response: ${response.body}');
      if(200 == response.statusCode){
        List <DailyStockCount> list =  parseResponse(response.body);
        return list;
      }else{
        return List<DailyStockCount>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<DailyStockCount>();//return an empty list on exception/ error
    }
  }




}



