import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../main.dart';

import '../model/Item.dart';
import '../services/Strings.dart';









class ItemsCloudDAO {


  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/items_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_ALL_ITEMS_LIST_ACTION = 'GET_ALL_ITEMS_LIST';
 static const _GET_BY_CLIENTID_ACTION =  "GET_BY_CLIENTID";
 static const _GET_BY_CATEGORY_ACTION = 'GET_BY_CATEGORY';
 static const _GET_BARCHART_DATA_BY_ITEMCODE_ACTION = 'GET_BARCHART_DATA_BY_ITEMCODE';
  static const _UPDATE_ITEM_ADDED_ACTION = 'UPDATE_ITEM_ADDED';
 static const _ADD_ITEM_ACTION = 'ADD_ITEM';
  static const _UPDATE_BARCODE_ACTION ='UPDATE_BARCODE';




  //get Items
  static Future<List<Items>> getItems() async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;
     //
      final response = await http.post(url, body: map);
    // print('get all Items Response: ${response.body}');
     // print('Status Items Response: ${response.statusCode}');
      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {

      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }

  static Future<List<Items>> getAllItemsList() async {

    print('imageURL '+ 'images/'+MyApp.db_name);
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ITEMS_LIST_ACTION;
      map["dbName"] = MyApp.db_name;

      final response = await http.post(url, body: map);

     // print('get all Items Response: ${response.body}');

      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {

      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }

  static Future<List<Items>> getItemsInPriceList(String id_price_list) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = "GET_ITEMS_BY_PRICE_LIST";
      map["dbName"] = MyApp.db_name;

      map["id_price_list"] = id_price_list;

      final response = await http.post(url, body: map);

     // print('get all Items Response: ${response.body}');

      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {

      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }

  //get Items
  static Future<List<Items>> getItemsByCategory( String category) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_BY_CATEGORY_ACTION;
      map["dbName"] = MyApp.db_name;


      map["category"] = category;

      final response = await http.post(url, body: map);
      //print('getItemsByCategory Response: ${response.body}');

      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {
      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }

  //get Items
  static Future<List<Items>> getItemsByClientID( String id_client) async {

    print('id_client: $id_client');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_BY_CLIENTID_ACTION;
      map["dbName"] = MyApp.db_name;
     //

      map["id_client"] = id_client;

      final response = await http.post(url, body: map);
       //print('get all Items Response: ${response.body}');
    //   print('Status Items Response: ${response.statusCode}');
      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {
      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }

  static List<Items> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Items>((json) => Items.fromJson(json)).toList();

  }

  static List<Items> parseResponseForChart(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Items>((json) => Items.fromJson(json));

  }

  //Method to update barcode for item in OPA database.
   static Future<String> updateItemBarcode(String id, String barcode) async {
    try {


      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_BARCODE_ACTION;
      map["dbName"] = MyApp.db_name;
     //

      map['id'] = id;
      map['barcode'] = barcode;


      final response = await http.post(url, body: map);
      //print('update barcode Response: ${response.body}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        print('error');
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }


    static Future<String> addItemToCloud(
        String id, String id_client, String  idCreatedStaff,  String  itemCode, String  description, String  barcode, String  articleNum, String  uom,
        String  status, String quantity,  double unitPrice, String  category,  String imageUrl) async {

      print('id'+ id);
      print('idclient  $id_client');
      print('idCreatedStaff $idCreatedStaff');
      print('itemCode $itemCode');
      print('description $description');
      print('barcode $barcode');
      print('articleNum $articleNum');
      print('uom $uom');
      print('status $status');
      print('quantity $quantity');
      print('unitPrice $unitPrice');
      print('category $category');
      print('imageUrl $imageUrl');

    try {


      var map = Map<dynamic, dynamic>();
      map['action'] =_ADD_ITEM_ACTION;
      map["dbName"] = MyApp.db_name;

      map['id'] =id;
      map['id_client'] =id_client;
      map['idCreatedStaff'] =idCreatedStaff == null ? '': idCreatedStaff;
      map['idDeletedStaff'] ="";
      map['itemCode'] =itemCode == null ? "" : itemCode;
      map['description'] =description == null ? "" : description;
      map['barcode'] =barcode == null ? "" : barcode;
      map['articleNum'] ='';
      map['uom'] =uom ==  null ? '': uom;
      map['deleted'] ='false';
      map['quantity'] = quantity == null ? 0 : quantity;
      map['unitPrice'] = unitPrice.toString() == null ? '0.0' : unitPrice.toString();
      map['category'] = category == null ? '': category;
      map['imageUrl'] =imageUrl == null ? '' : imageUrl;



      final response = await http.post(url, body: map);
      print('addItemToCloud  ' +response.body);

      if(200 == response.statusCode){

        return response.body;
      }else{

        return "errorX";
      }
    } catch (e) {
      print(e.toString());
      return "errorY";
    }
  }



  static Future<List<Items>> getBarchartDataByItemCode(String itemCode) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_BARCHART_DATA_BY_ITEMCODE_ACTION;
      map["dbName"] = MyApp.db_name;


      map["itemCode"] = itemCode;

      final response = await http.post(url, body: map);
      print('getBarchartDataByItemCode Response: ${response.body}');

      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return List<Items>();//return an empty list
      }
    } catch (e) {
      print(e);
      return List<Items>();//return an empty list on exception/ error
    }
  }


  static Future<List<Items>> getCurrentStock() async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = 'GET_CURRENT_STOCK';
      map["dbName"] = MyApp.db_name;

      final response = await http.post(url, body: map);

       print('getCurrentStock Response: ${response.body}');

      if(200 == response.statusCode){
        List <Items> list =  parseResponse(response.body);
        return list;
      }else{
        return <Items>[];//return an empty list
      }
    } catch (e) {

      print(e);
      return <Items>[];//return an empty list on exception/ error
    }
  }



}


