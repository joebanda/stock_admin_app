import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/model/Item.dart';
import '../../core/router/delegate.dart';
import '../../main.dart';
import 'items/ItemsInCloudPage.dart';
import 'stock_take/select_van_sales_agent.dart';



class Menu extends StatelessWidget {
  static List<Items> itemsList;
  final routerDelegate = Get.put(MyRouterDelegate());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: /*Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[200],
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton.icon(
                    onPressed: () {
                      //Navigator.pushNamed(context, 'SalesHeaderTable');
                      routerDelegate.pushPage(name: 'SalesHeaderTable');
                    },
                    icon: Icon(
                      Icons.assignment_turned_in,
                      color: Color(0xFF262AAA),
                      size: 40.0,
                    ),
                    label: Text('Stock take')),

              ],
            ),
          ),
        )*/

        Container(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  mainAxisSpacing: 20.0,crossAxisSpacing: 20.0
              ),
              children: [
                Container(child: ElevatedButton.icon(

                  onPressed: () => routerDelegate.pushPage(name: 'SalesHeaderTable'),

                 icon: const Icon(Icons.assignment_turned_in,
                  color: Colors.white,
                  size: 30.0,
                ), label: const Text('Stock take tasks',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),),),

                //**********************************************
                Container(child: ElevatedButton.icon(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectVanSalesAgents()));

                  Navigator.pushNamed(context,'DispatchHeaderTable');
                }, icon: const Icon(Icons.calendar_today_outlined,
                  color: Colors.white,
                  size: 30.0,
                ), label: const Text('Daily Stock Take',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),),),

                Visibility(
                  visible: MyApp.job_role.toUpperCase() == 'PRODUCT MANAGER'|| MyApp.job_role.toUpperCase() == 'ADMIN',
                  child: ElevatedButton.icon(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemsInCloudPage()));

                    //Navigator.pushNamed(context,'DispatchHeaderTable');
                  }, icon: const Icon(Icons.monetization_on_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ), label: const Text('Pricing',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),),
                ),

                //**********************************************
             /*   Container(child: ElevatedButton.icon(onPressed: (){
                  Navigator.pushNamed(context,'DeliveryHeaderTable');
                }, icon: const Icon(Icons.local_shipping,
                  color: Colors.white,
                  size: 30.0,
                ), label: const Text('Store Audit',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),),),*/
                //**********************************************
               /* Container(child: ElevatedButton.icon(onPressed: (){
                  Navigator.pushNamed(context,'home');
                }, icon: const Icon(Icons.house,
                  color: Colors.white,
                  size: 30.0,
                ), label: const Text('Tasks',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),),),*/
                //**********************************************
              ],
            ),
          ),
        )
    );
  }
}

