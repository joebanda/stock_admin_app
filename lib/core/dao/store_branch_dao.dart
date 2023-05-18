import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../main.dart';
import '../model/StoreBranch.dart';
import '../services/Strings.dart';





class StoreBranchDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/items_actions.php');

  ///Returns single [StoreBranch] object from selected [StocktakeTask.id_store_branch]
  static Future<StoreBranch> getStoreBranch(String id_store_branch) async {
    //print('Getting store branches by id $id_store_branch...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_BY_ID';
      map['id'] = id_store_branch;
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(
          AppStrings.storeBranchActionScript, body: map);
      //print('Get store branch for $id_store_branch response: ${response.body}');
      if (200 == response.statusCode) {
        List<StoreBranch> storeBranches = storeBranchFromJson(response.body);
        return storeBranches[0];
      } else {
        return StoreBranch(); //return an empty list
      }
    } catch (e) {
      return StoreBranch(); //return an empty list on exception/ error
    }
  }

  ///Returns list of all [StoreBranch] object from database
  static Future<List<StoreBranch>> getStoreBranches() async {
    print('Getting store branches list...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_ALL';
      map["dbName"] = MyApp.db_name;
      //map["dbPassword"] = _localStorageService.getDbPass;

      final response = await http.post(
          AppStrings.storeBranchActionScript, body: map);
      //print('Get store branches response: ${response.body}');
      if (200 == response.statusCode) {
        List<StoreBranch> storeBranches = storeBranchFromJson(response.body);
        return storeBranches;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }

  ///Returns list of [StoreBranch] object from [RetailRegion.id]
  static Future<List<StoreBranch>> getStoreBranchesByRegionId(
      String id_retail_region) async {
    print('Getting store branches list for region id $id_retail_region...');
    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = 'GET_BY_RETAIL_REGION_ID';
      map['id_retail_region'] = id_retail_region;
      map["dbName"] = MyApp.db_name;

      final response = await http.post(
          AppStrings.storeBranchActionScript, body: map);
      print('Get store branches by region response: ${response.body}');

      if (200 == response.statusCode) {
        List<StoreBranch> storeBranches = storeBranchFromJson(response.body);
        return storeBranches;
      } else {
        return []; //return an empty list
      }
    } catch (e) {
      return []; //return an empty list on exception/ error
    }
  }


}


