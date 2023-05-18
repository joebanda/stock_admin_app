import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


import 'package:meta/meta.dart';


import '../../main.dart';
import '../model/RetailRegion.dart';
import '../model/StaffLocation.dart';
//import '../model/StoreBranch.dart';
import '../model/stocktake_count.dart';
import '../model/stocktake_task.dart';
//import '../model/supplier.dart';
import 'Strings.dart';

/// Responsible for making all network requests
class Api {
  var userDataJson;


  ///Checks connectivity. Shows toast if device is not connected to the internet.
  static Future<ConnectivityResult> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.none){
      Fluttertoast.showToast(msg: 'You\'re not connected to the internet.');
    }
    return connectivityResult;
  }

  ///Show network error toast on [SocketException]
  static void onSocketException()=>Fluttertoast.showToast(msg: 'Network error. Check your connection and try again.');


  static Future<List<StaffLocation>> getStaffLocations(String id_staff) async {
    print('Getting staff locations by status...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_STAFF_LOCATIONS_BY_USER_ID';
      map['id_staff'] = id_staff;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(
          AppStrings.staffLocationActionScript, body: map);
      print('Get staff locations for $id_staff response: ${response.body}');
      if (200 == response.statusCode) {
        List<StaffLocation> list = staffLocationFromJson(response.body);
        return list;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }

  static Future<List<StocktakeTask>> getStockTakeTasksByStatusAndId({
    @required String id_staff, @required String status}) async {

    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_STOCKTAKETASKS_BY_STATUS_AND_ID';
      map['id_staff'] = id_staff;
      map['status'] = status;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(AppStrings.staffLocationActionScript, body: map);
     print('Get  stock take tasks for $id_staff response: ${response.body}');
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

  static Future<List<StocktakeCount>> getStockTakeCountByClientId(
      {@required String id_client,}) async {
    print('Getting stock take count by Client ID $id_client...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_STOCKTAKECOUNT_BY_CLIENT_ID';
      map['id_client'] = id_client;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(
          AppStrings.countActionScript, body: map);
      print('Get  stock take count for clientID $id_client response: ${response.body}');
      if (200 == response.statusCode) {
        List<StocktakeCount> list = stockTakeCountFromJson(response.body);
        return list;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }

  static Future<List<StocktakeCount>> getStockTakeCountByStoreBranchId(
      {@required String id_store_branch,}) async {
    print('Getting stock take count by store branch id $id_store_branch...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_STOCKTAKECOUNT_BY_STOREBRANCH_ID';
      map['id_store_branch'] = id_store_branch;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(
          AppStrings.staffLocationActionScript, body: map);
      print('Get  stock take count for $id_store_branch response: ${response
          .body}');
      if (200 == response.statusCode) {
        List<StocktakeCount> list = stockTakeCountFromJson(response.body);
        return list;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      print('$e');
      return []; //return an empty list on exception/ error
    }
  }



  ///Returns list of all [RetailRegion] objects from database
  static Future<List<RetailRegion>> getRetailRegions() async {
    print('Getting retail regions list...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_ALL_RETAIL_REGIONS';
      map["dbName"] = MyApp.db_name;

      final response = await http.post(
          AppStrings.retailRegionsActionScript, body: map);
      //print('Get store branches response: ${response.body}');
      if (200 == response.statusCode) {
        List<RetailRegion> retailRegions = retailRegionFromJson(response.body);
        return retailRegions;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }

  ///Update [StocktakeCount.qty]
  static Future<String> updateQty(String id, String qty) async {
    print('Updating $id qty...');
    try {
      var map = Map<String, dynamic>();
      map['action'] = 'UPDATE_QTY';
      map["dbName"] = MyApp.db_name;
      map["id"] = id;
      map["qty"] = qty.toString();

      final response = await http.post(AppStrings.countActionScript, body: map);
      print('Update QTY Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error UpdateQty 1";
      }
    } on SocketException catch (e) {
      print('Caught exception: $e');
      onSocketException();
      return 'error UpdateQty';
    } catch (e) {
      print(e.toString());
      return "error UpdateQty 2";
    }
  }

  ///Parse [StocktakeTask] json response
  static List<StocktakeTask> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<StocktakeTask>((json) => StocktakeTask.fromJson(json))
        .toList();
  }


} 
