
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../Widgets/my_date_picker.dart';


class QtyInputPad extends StatefulWidget {

  // String qty ;
   String title;
   String  include_expiry_date;
   String count_by_bins;
   String include_rate_of_sales;
   String includeBatchNo;

  // StocktakeTask stocktakeTask;
 // QtyInputPad(this.title, this.stocktakeTask);
   QtyInputPad(this.title, this.include_expiry_date,this.count_by_bins, this.include_rate_of_sales, this.includeBatchNo);

 // String text;


  @override
  QtyInputPadState createState() => QtyInputPadState();
}

class QtyInputPadState extends State<QtyInputPad> {

  String _qty;
  var datePicked ;
  String binNumber = '';
  double rateOfSales = 0.0;
  String batch_no;



  @override
  void initState() {

    super.initState();
    _qty = '';


  }

  //UI
  @override
  Widget build(BuildContext context) {


  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.title,
      style: TextStyle(fontSize: 10),), //show progress
      actions: <Widget>[],
    ),
    body: Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_qty, style: TextStyle(
              fontSize: 30,
                  fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey[600],
            ),),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Color(0xFF262AAA),
              rightButtonFn: () {
                setState(() {
                  _qty = _qty.substring(0, _qty.length - 1);
                });
              },
              rightIcon: Icon(
                Icons.backspace,
                color: Color(0xFF262AAA),
              ),
              /*leftButtonFn: () {
                print('left button clicked');
              },
              leftIcon: Icon(
                Icons.check,
                color: Colors.blue,
              ),*/
            ),
            SizedBox(),
            ElevatedButton.icon(
              onPressed: () async {

                    if(_qty==''){
                      return;
                        }



                   // print('expiry date ${widget.include_expiry_date}');

                   if(widget.include_expiry_date == 'true')  {
                      print('True expiry date ${widget.include_expiry_date}');


                      datePicked = await MyDatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime(2022),
                        titleText: 'Expiry Date',
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2030),
                        dateFormat: "dd-MMMM-yyyy",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                   }

                    if(widget.include_rate_of_sales== 'true') {
                      //print('ROS XXX ${widget.include_rate_of_sales}');
                      await   createROSAlertDialog(context).then((value) {

                        setState(() {
                          rateOfSales = double.parse(value);
                          print('Value $value');
                        });


                       /* Navigator.pop(context, {
                          'qtyPicked': _qty,
                          'expiryDate': datePicked.toString(),
                          'binNumber':binNumber,
                          'ros':rateOfSales,
                        });*/

                      });
                    }

                    if(widget.includeBatchNo== 'true') {

                      await   createBatchNoDialog(context).then((value) {

                        setState(() {
                          batch_no = value;
                          print('batchNo $value');
                        });



                      });
                    }

                    if(widget.count_by_bins== 'true') {
                      await   createBinNmberDialog(context).then((value) {
                        setState(() {
                          binNumber = value;
                          print('batchNo $value');
                        });

                      });
                    }

              Navigator.pop(context, {
              'qtyPicked': _qty,
              'expiryDate': datePicked.toString(),
              'binNumber': binNumber,
              'ros':rateOfSales,
              'batch_no': batch_no
               });




                 /*   if(widget.include_rate_of_sales== 'true') {
                      //print('ROS XXX ${widget.include_rate_of_sales}');
                   await   createROSAlertDialog(context).then((value) {

                        rateOfSales = double.parse(value);
                        print('Value $value');
                        Navigator.pop(context, {
                          'qtyPicked': _qty,
                          'expiryDate': datePicked.toString(),
                          'binNumber':binNumber,
                          'ros':rateOfSales,
                        });

                      });
                    }else {
                      Navigator.pop(context, {
                        'qtyPicked': _qty,
                        'expiryDate': datePicked.toString(),
                        'binNumber': binNumber,
                        'ros':rateOfSales,
                      });
                    }*/

               /*     if(widget.count_by_bins == 'true') {
                 await     createAlertDialog(context).then((value) {

                        binNumber = value;

                        Navigator.pop(context, {
                          'qtyPicked': _qty,
                          'expiryDate': datePicked.toString(),
                          'binNumber':binNumber,
                          'ros':rateOfSales,
                        });

                      });
                    }else {
                      Navigator.pop(context, {
                        'qtyPicked': _qty,
                        'expiryDate': datePicked.toString(),
                        'binNumber': binNumber,
                        'ros':rateOfSales,
                      });
                    }*/







              },
              icon: Icon(
                Icons.done_outline,
                color: Colors.green[400],
                size: 60.0,
              ),
              label: Text('Correct'),
    /* shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)
              ),*/
              //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            )
          ],
        ),
      ),
    ),


  );


  }

  _onKeyboardTap(String value) {
    setState(() {
      _qty = _qty + value;
    });
  }

  //Bin Number input dialog
  Future<String> createBinNmberDialog(BuildContext context){
    TextEditingController _binNumberController = TextEditingController();


    return showDialog(context: context, barrierDismissible: false,builder: (context){

      return AlertDialog(
        title: Text('Enter Bin Number'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          height: 40,
          child: Column(
              children: <Widget>[
                TextField(
                  controller: _binNumberController,
                  decoration: InputDecoration.collapsed(hintText: 'Bin Number'),

                ),

              ]
          ),
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){

              if (_binNumberController.text.isEmpty ) {
                print('Empty Fields');
                return;
              }
              String binNumber  = _binNumberController.text.toString();
              Navigator.of(context).pop(binNumber);
            },
          ),
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

  //Bin Number input dialog
  Future<String> createROSAlertDialog(BuildContext context){
    TextEditingController rosController = TextEditingController();


    return showDialog(context: context, barrierDismissible: false,builder: (context){

      return AlertDialog(
        title: Text('Weekly Rate of Sales'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          height: 60,
          child: Column(
              children: <Widget>[
                TextField(
                  controller: rosController ,
                  decoration: InputDecoration.collapsed(hintText: 'Enter Weekly Rate of Sales'),
                  maxLength: 9,
                  inputFormatters: [
                    FilteringTextInputFormatter(
                        RegExp(
                            "[0-9.]"),
                        allow:
                        true),
                  ],

                ),

              ]
          ),
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){

              if (rosController .text.isEmpty ) {
                print('Empty Fields');
                return;
              }
              String ros  = rosController .text.toString();
             Navigator.of(context).pop(ros);
            },
          ),
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

  //Bin Number input dialog
  Future<String> createBatchNoDialog(BuildContext context){
    TextEditingController _controller = TextEditingController();


    return showDialog(context: context, barrierDismissible: false,builder: (context){

      return AlertDialog(
        title: Text('Enter Batch Number'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: Container(
          height: 40,
          child: Column(
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration.collapsed(hintText: 'Batch Number'),

                ),

              ]
          ),
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){

              if (_controller.text.isEmpty ) {
                print('Empty Fields');
                return;
              }
              String batch_no  = _controller.text.toString();
              Navigator.of(context).pop(batch_no);
            },
          ),
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
