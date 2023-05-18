import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../main.dart';


import '../model/item_price_list.dart';
import '../model/price_list.dart';
import '../services/Strings.dart';





class PriceListDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/price_list_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _CREATE_PRICE_LIST_ACTION = 'CREATE_PRICE_LIST';



  static const _GET_PRICELIST_TO_ADD_ITEM_ACTION  = "GET_PRICELIST_TO_ADD_ITEM";




  //get Items
  static Future<List<PriceList>> getPriceLists() async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;
    //

      final response = await http.post(url, body: map);
     // print('get getPriceLists Response: ${response.body}');
      if(200 == response.statusCode){
        List <PriceList> list =  parseResponse(response.body);
        return list;
      }else{
        return List<PriceList>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<PriceList>();//return an empty list on exception/ error
    }
  }

  static Future<String> createPriceList(PriceList priceList) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = _CREATE_PRICE_LIST_ACTION;
      map["dbName"] = MyApp.db_name;

      map['id'] = priceList.id;
      map['priceListName'] = priceList.priceListName;
      map['description'] = priceList.description;
      map['idCurrency'] = priceList.idCurrency;
      map['currencySymbol'] = priceList.currencySymbol;
     //TODO map['isActive'] = priceList.isActive;
      //TODO map['isDefault'] = priceList.isDefault;
      //TODO map['isTaxable'] = priceList.isTaxable;
      //TODO map['isPriceIncludeTax'] = priceList.isPriceIncludeTax;
      //TODO map['startDate'] = priceList.startDate;
      //TODO map['endDate'] = priceList.endDate;

      final response = await http.post(url, body: map);

    //  print('create price list Response: ${response.body}');
      if(response.statusCode == 200){

        return response.body;
      }else{
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> assignItemToPriceList({String id,String id_item,String id_price_list, String price}) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = "ASSIGN_ITEM_TO_PRICE_LIST";
      map["dbName"] = MyApp.db_name;

      map['id'] = id;
      map['id_item'] = id_item;
      map['id_price_list'] = id_price_list;
      map['price'] = price;


      final response = await http.post(url, body: map);

     // print('assignItemToPriceList Response: ${response.body}');
      if(response.statusCode == 200){

        return response.body;
      }else{
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }


  static List<PriceList> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PriceList>((json) => PriceList.fromJson(json)).toList();

  }



  static Future<List<PriceList>> getPriceListsByItem(String id_item) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_PRICE_LISTS_BY_ITEM';
      map["dbName"] = MyApp.db_name;
      map["id_item"] = id_item;
      //

      final response = await http.post(url, body: map);
      print('getPriceListsByItem Response: ${response.body}');
      if(200 == response.statusCode){
        List <PriceList> list =  parseResponse(response.body);
        return list;
      }else{
        return List<PriceList>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<PriceList>();//return an empty list on exception/ error
    }
  }

  static Future<List<PriceList>> getPriceListToAddItem(String id_item) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_PRICELIST_TO_ADD_ITEM_ACTION;
      map["dbName"] = MyApp.db_name;
      map["id_item"] = id_item;
      //

      final response = await http.post(url, body: map);
      //print('get all Items in OPA Response: ${response.body}');
      if(200 == response.statusCode){
        List <PriceList> list =  parseResponse(response.body);
        return list;
      }else{
        return List<PriceList>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<PriceList>();//return an empty list on exception/ error
    }
  }



  static Future<String> updateItemPrice({String id_item, String id_price_list, String new_price}) async {

  /*  print('id_item: $id_item');
    print('id_price_list: $id_price_list');
    print('new_price: $new_price');*/


    try {

      var map = Map<String, dynamic>();
      map['action'] = "UPDATE_ITEM_PRICE";
      map["dbName"] = MyApp.db_name;


      map['id_item'] = id_item;
      map['id_price_list'] = id_price_list;
      map['price'] = new_price;


      final response = await http.post(url, body: map);

     // print('updateItemPrice Response: ${response.body}');
      if(response.statusCode == 200){

        return response.body;
      }else{
        return "errorX";
      }
    } catch (e) {
      return "errorY";
    }
  }


  static Future<String> addItemPrice({String id, String id_item, String id_price_list, String new_price, String idCurrency, String currencySymbol}) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = "ADD_ITEM_PRICE";
      map["dbName"] = MyApp.db_name;


      map['id'] = id;
      map['id_item'] = id_item;
      map['id_price_list'] = id_price_list;
      map['price'] = new_price;
      map['idCurrency'] = idCurrency;
      map['currencySymbol'] = currencySymbol;


      final response = await http.post(url, body: map);

      //print('updateItemPrice Response: ${response.body}');
      if(response.statusCode == 200){

        return response.body;
      }else{
        return "errorX";
      }
    } catch (e) {
      return "errorY";
    }
  }


  static Future<List<PriceList>> getPricesForAllItems()  async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_PRICES_FOR_ALL_ITEMS';
      map["dbName"] = MyApp.db_name;

      //

      final response = await http.post(url, body: map);
      //print('get all Items in OPA Response: ${response.body}');
      if(200 == response.statusCode){
        List <PriceList> list =  parseResponse(response.body);
        return list;
      }else{
        return List<PriceList>();//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return List<PriceList>();//return an empty list on exception/ error
    }
  }



  static Future<List<PriceList>> getPriceListItemsByCompany(String id_company) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_PRICE_LIST_ITEMS_BY_COMPANY';
      map["dbName"] = MyApp.db_name;
      map["id_company"] = id_company;


      final response = await http.post(url, body: map);
     // print('getPriceListItemsByCompany Response: ${response.body}');
      if(200 == response.statusCode){
        List <PriceList> list =  parseResponse(response.body);
        return list;
      }else{
        return <PriceList>[];//return an empty list
      }
    } catch (e) {
      print(e.toString());
      return <PriceList>[];//return an empty list on exception/ error
    }
  }



  static Future<String> saveItemsPriceList(List<ItemPriceList> jsonValue) async {


    String json = jsonEncode(jsonValue.map((i) => i.toJson()).toList()).toString();





    try {

      var map = Map<String, dynamic>();
      map['action'] = 'SAVE_ITEMS_PRICE_LIST';
      map["dbName"] = MyApp.db_name;
      map['json_value'] = json;


      final response = await http.post(url, body: map);
      //print('Add Items List Response: ${response.body}');
    //  print('Add Items List Response: ${response.statusCode}');
      if(200 == response.statusCode){

        return response.body;
      }else{
        return "error1";
      }
    } catch (e) {
      return e.toString() ;
    }
  }




}



