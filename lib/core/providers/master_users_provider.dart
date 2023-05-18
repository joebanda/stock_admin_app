

import 'package:flutter/material.dart';


import '../../main.dart';
import '../dao/master_users_dao.dart';
import '../model/master_user_model.dart';






class MasterUserProvider with ChangeNotifier{

  List<MasterUserModel> _usersList =[];
  List<MasterUserModel> _fullUsersList =[];

  List<MasterUserModel> _storesNotAddedList =[];

  bool isSearching = false;

  List get usersList => _usersList;
  List get fullUsersList => _fullUsersList;


  bool get isSearchingStatus => isSearching;

  void getUsersList(){

    isSearching = true;
    _usersList =[];


    MasterUsersDAO.getUsersByDbName(MyApp.db_name).then((value) {

      isSearching = false;

      _usersList = _fullUsersList =value;

      notifyListeners();

    });

  }











  void SearchByFirstName(String keywordTyped){
    isSearching = true;
    //_itemsList =[];
    if(keywordTyped.isEmpty){
      isSearching = false;
      _usersList = _fullUsersList;
      notifyListeners();
    }else{
      isSearching = false;
      _usersList = _fullUsersList.where((element) => element.id.toLowerCase().contains(keywordTyped.toLowerCase())).toList();
      notifyListeners();
    }
  }

  void getUsersByRole(String job_role) {
    isSearching = true;
    _usersList =[];

    MasterUsersDAO.getStaffListByJobTitle(job_role).then((value) {

      isSearching = false;

      _usersList = _fullUsersList =value;

      notifyListeners();

    });
  }



}