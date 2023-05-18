import 'package:flutter/material.dart';

import '../../core/model/master_user_model.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MasterUserModel selectedUser;
  String assignedUser = 'all';
  double statsHeightAuth = 230;
  double statsHeightUnAuth = 80;
  //LocalStorageService _localStorageService = locator<LocalStorageService>();
  // Position position;
  // Future<Position> getPosition()async{
  //   if(position==null){
  //     print('---------POSITION IS NULL--------');
  //     position = await LocationService.getCurrentLocation(context);
  //   }else{
  //     print('CURRENT POSITION = LAT:${position.latitude} LNG:${position.longitude}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            //Header
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Color(0xFF262AAA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('LogistixPro',style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.normal)),
                        Text('build. 211021',style: TextStyle(color: Colors.white,fontSize: 10.0,fontWeight: FontWeight.normal)),

                      ],
                    )
                  ],
                ),
              ),
            ),
            //Statistics
            DefaultTabController(
              length: 1,
              initialIndex: 0,
              child: SliverPadding(
                padding: EdgeInsets.all(18.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: false,
                        onTap: (index)=>setState((){

                        }),
                        indicatorColor: Colors.transparent,
                        // labelStyle: Styles.tabTextStyle,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        tabs: <Widget>[
                          Text('',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),

                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // height: AppLists.jobTitles.contains(_storageService.user.jobtitle.toString().toUpperCase())  ?
                        // statsHeightAuth : statsHeightUnAuth,
                        height: statsHeightAuth ,
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children:[
                              //Today
                              Container(
                                height: statsHeightAuth,
                                child: Column(
                                  children: <Widget>[
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          _buildStatCard(
                                            title:'> 10 Weeks',
                                            count: '450',//model.state==ViewState.Busy ? '' : '${model.getTotalTimeClocked()}',
                                            color: Colors.red,
                                          ),
                                          _buildStatCard(
                                            title:'10 - 16 Weeks',
                                            count: '345',//model.totalBillable==null||model.state==ViewState.Busy ? '' : 'K${model.totalBillable.toString()}',
                                            color: Colors.orange,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          _buildStatCard(
                                            title: '> 16 Weeks',
                                            count: '5560',//AppLists.jobTitles.contains(_storageService.user.jobtitle.toString().toUpperCase())  ? 'K${model.debtors}' : '',
                                            color: Colors.green,
                                          ),
                                          _buildStatCard(
                                            title: 'Open Tasks',
                                            count:'21',// AppLists.jobTitles.contains(_storageService.user.jobtitle.toString().toUpperCase())? 'K${model.payments}' : '',
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          _buildStatCard(
                                            title: 'Started',
                                            count: '11',//AppLists.jobTitles.contains(_storageService.user.jobtitle.toString().toUpperCase())  ? 'K${model.officeExpenses}' : '',
                                            color: Colors.purple,
                                          ),
                                          _buildStatCard(
                                            title: 'Not Started',
                                            count: '10',//AppLists.jobTitles.contains(_storageService.user.jobtitle.toString().toUpperCase())? 'K${model.clientFunds}' : '',
                                            color: Colors.blueGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    //);
  }
  Expanded _buildStatCard({String title, String count, MaterialColor color,}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular((10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600),),
            Text(count, style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold),),
          ],
        ),),
    );
  }
}


