import 'dart:convert';

import 'package:http/http.dart' as http;



import '../../main.dart';
import '../model/Item.dart';
import '../services/Strings.dart';









class ItemsDAO {
  //static const ROOT = AppStrings.ROOT+'/items_actions.php';
  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/items_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _UPDATE_BARCODE_ACTION ='UPDATE_BARCODE';
  static const _GET_ITEM_BY_BARCODE_ACTION = 'GET_ITEM_BY_BARCODE';

  //static LocalStorageService _localStorageService = locator<LocalStorageService>();


  //get Items
  static Future<List<Items>> getItems() async {
    print('ItemsDAO getting items...');
    // print('888888888888888888888888888');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;
     // print('777777777777777777777777');
      final response = await http.post(url, body: map);
      //print('6666666666666666666666666');
      print('get all Items in stocktake Response: ${response.body}');
      if(200 == response.statusCode){
        List <Items> list = parseResponse(response.body);
        return list;
      }else{
        return [];//return an empty list
      }
    } catch (e) {

      //TODO Add
      print(e.toString());
      return [];//return an empty list on exception/ error
    }
  }

  static List<Items> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Items>((json) => Items.fromJson(json)).toList();

  }

  //Method to update barcode for item in stocktake database.
   static Future<String> updateItemBarcode(String No_, String barcode) async {
    try {


      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_BARCODE_ACTION;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;
      map['No_'] = No_;
      map['barcode'] = barcode;

      final response = await http.post(url, body: map);
     // print('update barcode Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }


  //get Items
  static Future<List<Items>> getItemsByBarcode(String barcode) async {
    print('Getting item by barcode $barcode...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] =  _GET_ITEM_BY_BARCODE_ACTION;
      map["dbName"] = MyApp.db_name;
      map['barcode'] = barcode;

      final response = await http.post(url, body: map);
      print('getItemsByBarcode stocktake Response: ${response.body}');
      if(200 == response.statusCode){
        List <Items> list = parseResponse(response.body);
        return list;
      }else{
        return [];//return an empty list
      }
    } catch (e) {
      print('Caught error: $e');
      return [];//return an empty list on exception/ error
    }
  }

  static Future<List<Items>> getVanSalesStock(String id_user) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'getMyStock';
      map["dbName"] = MyApp.db_name;
      map['id_user'] = id_user;


      final response = await http.post(url, body: map);
      //print('getMyStock Response: ${response.body}');
      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return <Items>[];//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return <Items>[];//return an empty list on exception/ error
    }
  }

  static deleteItem({String id}) async {




    try {

      var map = Map<String, dynamic>();
      map['action'] = 'DELETE ITEM';
      map["dbName"] = MyApp.db_name;
      map['id'] = id;


      final response = await http.post(url, body: map);
     // print('UPDATE deleteItem : ${response.body}');

      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error1";
      }
    } catch (e) {
      return e.toString() ;
    }
  }



  //get Itemcode by barcode
/*  static Future<String> getItemcodeByBarcode(String barcode) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_ITEMCODE_BY_BARCORD_ACTION;
      map['barcode'] = barcode;
      final response = await http.post(ROOT, body: map);
      print('get Itemscode by Barcode Response: ${response.body}');
      if(200 == response.statusCode){

        String itemcode = response.body;
        return itemcode;
        //List <Items> list = parseResponse(response.body);
       // return list;
      }else{

        return '';
        //return List<Items>();//return an empty list
      }
    } catch (e) {
      return '';
      //return List<Items>();//return an empty list on exception/ error
    }
  }*/





}


