import 'dart:convert';

import 'package:http/http.dart' as http;



import '../../main.dart';
import '../model/Item.dart';
import '../model/supplier.dart';
import '../services/Strings.dart';





class SupplierDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/suppliers.php');


  static const _GET_ALL_SUPPLIERS_ACTION = 'GET_ALL_SUPPLIERS';






  Future<List<Supplier>> getSuppliers({bool loadFromApi = true}) async {

    try {
      var map = Map<String, dynamic>();



      map['action'] = _GET_ALL_SUPPLIERS_ACTION;
      map["dbName"] = MyApp.db_name;
      final response = await http.post(url, body: map);

      print("getSuppliers response: " + response.body.toString());
      if (response.statusCode == 200) {

        List<Supplier> list = parseAccount(response.body);
        list.sort((a, b) =>
            a.supplier_name.toString().compareTo(b.supplier_name.toString()));
        return list;
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }



  List<Supplier> parseAccount(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Supplier>((json) => Supplier.fromJson(json)).toList();
  }

}


