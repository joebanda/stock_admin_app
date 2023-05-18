

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/dao/ItemsDAO.dart';
import '../../../core/model/Item.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
  static  List<Items> itemsList=[];
 /* static getItemsList() {
    return itemsList;
  }*/
}

class _LoadingState extends State<Loading> {

  String listlength ='Loading';

  void getItems(){

    print('Hello');
    ItemsDAO.getItems().then((value) {
      print(value.length);

      Loading.itemsList = value;

     //TODO add dialog to check if you have internet connection
      if(value.length > 0) {

        //TODO bypass login
       // Navigator.pushReplacementNamed(context, '/login');
        //TODO hardcoded login details in main.dart
        Navigator.pushReplacementNamed(context,'home');
        //Navigator.pushReplacementNamed(context, '/loginLoading');
      }else{

        //TODO show dialog
        createAlertDialog(context);
      }

      /*setState(() {

        listlength = itemsList.length.toString();
      });*/
    //  print(itemsList.length);
      //print('hhhhhhhhhhh');
    });
  }

 /* static List<Items> getItemsList(){
    return itemsList;
  }*/

  @override
  void initState() {

    super.initState();
    getItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  SpinKitCubeGrid(
          color: Color(0xFF262AAA),
          size: 80.0,
        ),
      )

    );
  }


  Future<String> createAlertDialog(BuildContext context){


    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Error'),
        content: Column(
            children: <Widget>[
              Text('Unable to connect to server, \nplease check your internet \nand restart the stock take App'),
              /*  SizedBox(
                height: 30,
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration.collapsed(hintText: 'Location or Reference'),
              ),*/
            ]
        ),

        actions: <Widget>[

          MaterialButton(
            elevation: 5.0,
            child: Text('Cancel'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
