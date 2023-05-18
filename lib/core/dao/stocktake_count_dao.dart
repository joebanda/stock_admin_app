import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../main.dart';
import '../model/stocktake_count.dart';
import '../services/Strings.dart';








class StocktakeCountDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/count_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_ACTION ='_ADD';
  static const _GET_BY_ID_ACTION = 'GET_BY_ID';
  static const _DELETE_BY_ID_ACTION = 'DELETE_BY_ID';
  static const _UPDATE_AS_DELETED_ACTION = 'UPDATE_AS_DELETED';



  static Future<List<StocktakeCount>> getObjects() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(url, body: map);
      //print('get all objects Response: ${response.body}');
      if(200 == response.statusCode){
        List <StocktakeCount> list = parseResponse(response.body);
        return list;
      }else{
        return [];//return an empty list
      }
    } catch (e) {
      return [];//return an empty list on exception/ error
    }
  }

  static List<StocktakeCount> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<StocktakeCount>((json) => StocktakeCount.fromJson(json)).toList();

  }


  // add stock count line.
  static Future<String> addObject(String id ,String id_stocktake_task ,String id_item , String id_ceated_staff , String qty ,
      String bin_number, String rate_of_sale, String date_expiry, String description, String barcode,  String reference
      ,String id_store_branch , String id_client, String batch_no) async {

    print('date_expiry: ${date_expiry}');
    try {

      var map = Map<String, dynamic>();
      map['action'] = _ADD_ACTION;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      map["id"] = id;
      map["id_stocktake_task"] = id_stocktake_task;
      map["id_item"] = id_item;
      map["id_ceated_staff"] =id_ceated_staff;
      map["qty"] = qty;
      map["bin_number"] = bin_number;
      map["rate_of_sale"] = rate_of_sale;
      map["date_expiry"] = date_expiry;
      map["description"] = description;
      map["barcode"] = barcode;
      //map["uom"] = uom;
      map["reference"] = reference;
      map["id_store_branch"] = id_store_branch;
      map["id_client"] = id_client;
      map["batch_no"] = batch_no == null ? '' : batch_no;

   //   map['date_created']= DateTime.now().toString();

//print('time now is ${DateTime.now().toString()}');

      final response = await http.post(url, body: map);
     print('add count object Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error StocktakeCountDAO add 1A";
      }
    } catch (e) {
      print(e.toString());
      return "error StocktakeCountDAO 2A";
    }
  }




  static Future<List<StocktakeCount>> getById(String id_stocktake_task, String order_by) async {


    try {


      var map = Map<String, dynamic>();
      map['action'] = _GET_BY_ID_ACTION;
      map['id_stocktake_task'] = id_stocktake_task;
      map['order_by']= order_by;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;
      final response = await http.post(url, body: map);
   //print('get Stock count Response: ${response.body}');
      if(200 == response.statusCode){
        List <StocktakeCount> list = parseResponse(response.body);
        list.sort((a, b) => a.date_created.toString().compareTo(b.date_created.toString()));
        return list;
      }else{
        return List<StocktakeCount>();//return an empty list
      }
    } catch (e) {
      return List<StocktakeCount>();//return an empty list on exception/ error
    }
  }



  static Future<String> deleteByID(String id ) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = _DELETE_BY_ID_ACTION;
      map["id"] = id;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(url, body: map);
    //  print('delete object Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error StocktakeCountDAO 1B";
      }
    } catch (e) {
      print(e.toString());
      return "error StocktakeCountDAO 2B";
    }
  }

  //flags a count as deleted
  static Future<String> updateAsDeleted(String id, String id_deleted_staff ) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_AS_DELETED_ACTION;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;
      map["id"] = id;
      map["id_deleted_staff"] = id_deleted_staff;


      final response = await http.post(url, body: map);
     //   print('update deleted object Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error StocktakeCountDAO 1C";
      }
    } catch (e) {
      print(e.toString());
      return "error StocktakeCountDAO 2C";
    }
  }



}
