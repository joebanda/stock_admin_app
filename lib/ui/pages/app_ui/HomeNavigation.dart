import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/model/master_user_model.dart';
import '../../../core/router/delegate.dart';
import '../../../core/services/AppLists.dart';
import '../../../core/services/AppTheme.dart';
import '../../../main.dart';
import '../dashboard.dart';

import '../menu.dart';
import '../report_select_page.dart';


///BOTTOM NAVIGATION BAR COMPONENTv
class HomeNavigation extends StatefulWidget {

  int currentIndex;
  String title;
  MasterUserModel masterUserModel;

  HomeNavigation( {this.masterUserModel,this.currentIndex = 0, this.title = "Dashboard"});

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {

  final routerDelegate = Get.put(MyRouterDelegate());

  static List<String> _jobTitles = ['admin','supervisor','field supervisor'];

  final _navigationBarIconSize = 28.0;
  final _navigationBarTextSize = 14.0;

  ///Pages for main navigation
  final List<Widget> _children = [Dashboard(), Menu(),
    if(_jobTitles.contains(MyApp.job_role.toString().toLowerCase())) ReportsPage()];
  final List<String> _pageTitles = ['Dashboard', 'Select Function','Reports'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF262AAA),
        elevation: 0,
        // leading: UserAvatar(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(_pageTitles[widget.currentIndex],style: TextStyle(color: Colors.white,fontSize: 16),),
        textTheme:AppTheme.textTheme,
        actions: <Widget>[
          PopupMenuButton<String>(
              color: Colors.white,
              icon: Icon(Icons.more_vert_rounded,color: Colors.white,),
              onSelected: (String choice) async {
                if (choice == 'Logout') {

                    //TODO _storageService.clearUser();
                    SharedPreferences preferences = await SharedPreferences
                        .getInstance();
                    preferences.setString('emailKey', '');
                    preferences.setString('passwordKey', '');


                    routerDelegate.logOut();
                   // Get.offAllNamed('login');
                }
              },
              itemBuilder: (BuildContext context) {
                return AppLists.logout.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }
          ),
        ],
      ),
      body:  _children[widget.currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF262AAA),
        unselectedItemColor: Colors.grey[400],
        currentIndex: widget.currentIndex,
        onTap: _onTappedBar,

        ///List of bottom Navigation items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart,size: _navigationBarIconSize,),
            label: 'Dashboard',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in,size: _navigationBarIconSize,),
            label: 'Stock',


          ),
          if(_jobTitles.contains(MyApp.job_role.toString().toLowerCase())) BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart
              ,size: _navigationBarIconSize,),
            label: 'Reports',

          ),


        ],
      ),
    );
  }


  void _onTappedBar(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }



}

