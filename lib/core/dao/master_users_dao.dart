import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';


import '../../main.dart';
import '../model/master_user_model.dart';
import '../services/Strings.dart';







class MasterUsersDAO {

  static var url = Uri.http(AppStrings.HOST, AppStrings.API_FOLDER+'/master_user_actions.php');


  static const _LOGIN_ACTION = 'login';

  static const _GET_USERS_BY_DBNAME_ACTION = 'GET_USERS_BY_DBNAME';

  static const _RESET_PASSWORD_ACTION = 'RESET_PASSWORD';

  static const _ADD_USER_ACTION = 'ADD_USER';

  static const _DELETE_USER_ACTION = 'DELETE_USER';

  static const _UPDATE_USER_ACTION = 'UPDATE_USER';

  static const _GET_STAFFLIST_BY_JOBTITLE = 'GET_STAFFLIST_BY_JOBTITLE';


  static Future<List<MasterUserModel>> authenticateUser(String email, String password) async {

    //print('email ${email} password ${password}');
    try {

      var map = Map<String, dynamic>();
      map['action'] = _LOGIN_ACTION;


      map['email'] = email;
      map['password'] = password;


      final response = await http.post(url, body: map);
      //print('authenticateUser Response: ${response.body}');
      // print(response.statusCode);
      if (200 == response.statusCode) {

        List<MasterUserModel> list = parseResponse(response.body);


        print(list.length);
        return list;
      } else {
        return List<MasterUserModel>(); //return an empty list
      }
    } catch (e) {
      print(e);
      return List<MasterUserModel>(); //return an empty list on exception/ error
    }
  }

  static Future<List<MasterUserModel>> getUsersByDbName(String db_name) async {


    try {

      var map = Map<String, dynamic>();
      map['action'] = _GET_USERS_BY_DBNAME_ACTION;
      map['db_name'] = db_name;

      final response = await http.post(url, body: map);
      //print('authenticateUser getUsersByDbName(: ${response.body}');

      if (response.statusCode == 200) {

        List<MasterUserModel> list = parseResponse(response.body);


        print(list.length);
        return list;
      } else {
        return List<MasterUserModel>(); //return an empty list
      }
    } catch (e) {
      print(e);
      return List<MasterUserModel>(); //return an empty list on exception/ error
    }
  }








  static List<MasterUserModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MasterUserModel>((json) => MasterUserModel.fromJson(json))
        .toList();
  }

  static Future<List<MasterUserModel>>  getStaffListByJobTitle(String jobtitle) async {

    try {
      //add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _GET_STAFFLIST_BY_JOBTITLE;
      map["job_role"] = jobtitle;
      map['db_name'] = MyApp.db_name;


      final response = await http.post(url, body: map);
      print('getStaffListByJobTitle Response1: ${response.body}');

      if (200 == response.statusCode) {

        List<MasterUserModel> list = parseResponse(response.body);
        // print(list[0].firstname);

        //  print(list.length);
        return list;
      } else {
        return List<MasterUserModel>(); //return an empty list
      }
    } catch (e) {
      // print(e);
      return List<MasterUserModel>(); //return an empty list on exception/ error
    }
  }


}

