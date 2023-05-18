import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';

import '../../main.dart';
import '../model/RetailRegion.dart';

import '../services/Strings.dart';



class RegionsDAO {


  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/retail_region_actions.php');
  static const _GET_ALL_ACTION = 'GET_ALL_RETAIL_REGIONS';
  static const _ADD_ACTION = 'ADD_RETAIL_REGION';
  static const _UPDATE_STATUS_ACTION = 'UPDATE_STATUS';

  static Future<List<RetailRegion>> getRegions() async {

    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map["dbName"] = MyApp.db_name;

      // map['status'] = status;

      final response = await http.post(url, body: map);
      print('get all regions Response: ${response.body}');
      print(response.statusCode);
      if (200 == response.statusCode) {

        List<RetailRegion> list = parseResponse(response.body);
        //print(list[0].chain_store_name);

        print(list.length);
        return list;
      } else {
        return List<RetailRegion>(); //return an empty list
      }
    } catch (e) {
      print(e);
      return List<RetailRegion>(); //return an empty list on exception/ error
    }
  }

  static List<RetailRegion> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RetailRegion>((json) => RetailRegion.fromJson(json))
        .toList();
  }

  //Method to add an object to the database.
  static Future<String> addObject(
      String stocktake_task_id,
      String chain_store_name,
      String branch_name,
      String status,
      String include_expiry_date,
      String count_by_bins) async {
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ACTION;
      map["dbName"] = MyApp.db_name;
      //

      map['stocktake_task_id'] = stocktake_task_id;
      map['chain_store_name'] = chain_store_name;
      map['branch_name'] = branch_name;
      map['status'] = status;
      map['include_expiry_date'] = include_expiry_date;
      map['count_by_bins'] = count_by_bins;

      //map['deleted'] = deleted;
      // map['date_created'] = date_created;
      // map['date_closed'] = date_closed;
      // map['note'] = note;
      final response = await http.post(AppStrings.chainStoreActionsScript, body: map);
      // print('add object Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //Method to add an object to the database.
  static Future<String> updateStatus(
      String status, String stocktake_task_id) async {
    var now = new DateTime.now();
    // print(now.toString().substring(0, 16));
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_STATUS_ACTION;
      map["dbName"] = MyApp.db_name;
      //

      map['stocktake_task_id'] = stocktake_task_id;
      map['status'] = status;
      map['date_closed'] = now.toString().substring(0, 16);
      final response = await http.post(AppStrings.chainStoreActionsScript, body: map);
      // print('UPDATE object Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }


  static Future<String> addRegion({@required String id,@required String region_name,
    @required String city, @required String province,@required String country})async{
    try {


      final response = await http.post(
          url,
          body: {
            "dbName": MyApp.db_name,
            "action": _ADD_ACTION,
            "id": id.toString(),
            "region_name": region_name.toString(),
            "city": city.toString(),
            "province": province.toString(),
            "country": country.toString().toUpperCase(),
            "deleted": 'false',
            "status": 'active',


          },
          headers: {"Accept": "application/json"});

      print('Add ChainStore Response: ${response.body}');
      if (response.statusCode == 200){
        return response.body.toString();
      } else {
        return "error";
      }
    } catch (e) {
      print('Caught error: ' + e.toString());
    }
  }

  //Get ChainStore  Details from DB
  List<RetailRegion> parseChainStore(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RetailRegion>((json) => RetailRegion.fromJson(json)).toList();
  }
}


