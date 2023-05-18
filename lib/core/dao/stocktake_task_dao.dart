import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../main.dart';
import '../model/stocktake_task.dart';
import '../services/Strings.dart';





class StocktakeTaskDAO {
  // static const ROOT = AppStrings.ROOT+'/stocktake_task_actions.php';
   static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/stocktake_task_actions.php');

   static const _GET_STOCKTAKETASKS_BY_STATUS_ACTION = 'GET_STOCKTAKETASKS_BY_STATUS';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_ALL_BY_FACILITY = 'GET_ALL_BY_FACILITY';
  static const _ADD_ACTION = '_ADD';
  static const _UPDATE_STATUS_ACTION = 'UPDATE_STATUS';

  static Future<List<StocktakeTask>> getObjects(String status) async {
    print('Getting stocktasks by status...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_STOCKTAKETASKS_BY_STATUS_ACTION;
      map['status'] = status;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;


      final response = await http.post(url, body: map);
      print('Get all objects Response: ${response.body}');
      if (200 == response.statusCode) {
        List<StocktakeTask> list = parseResponse(response.body);
        return list;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }

   static Future<List<StocktakeTask>> getStockTakeTasksByFacilityID(String status,String facility_id) async {
     try {
       //add the parameters to pass to the request.
       var map = Map<String, dynamic>();
       map['action'] =_GET_ALL_BY_FACILITY ;
       map["dbName"] = MyApp.db_name;
       //map["dbPassword"] = _localStorageService.getDbPass;
       map['status'] = status;
       map['facility_id'] = facility_id;

       final response = await http.post(url, body: map);
       // print('get all objects Response: ${response.body}');
       if(200 == response.statusCode){
         List <StocktakeTask> list = parseResponse(response.body);
         return list;
       }else{
         return [];//return an empty list
       }
     } catch (e) {
       return [];//return an empty list on exception/ error
     }
   }


   static List<StocktakeTask> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<StocktakeTask>((json) => StocktakeTask.fromJson(json))
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
      //map["dbPassword"] = _localStorageService.getDbPass;

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
      final response = await http.post(url, body: map);
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
      //map["dbPassword"] = _localStorageService.getDbPass;

      map['stocktake_task_id'] = stocktake_task_id;
      map['status'] = status;
      map['date_closed'] = now.toString().substring(0, 16);
      final response = await http.post(url, body: map);
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
}
