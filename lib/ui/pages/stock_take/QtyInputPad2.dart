
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:numeric_keyboard/numeric_keyboard.dart';






class QtyInputPad2 extends StatefulWidget {

  /*SalesOrderDetail salesOrderDetailLine;
   QtyInputPad({this.salesOrderDetailLine,Key key}) : super(key: key);*/

  String description;
 double qty;

  QtyInputPad2({this.description,this.qty,Key key}) : super(key: key);

 // String text;


  @override
  QtyInputPadState createState() => QtyInputPadState();
}

class QtyInputPadState extends State<QtyInputPad2> {

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
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      //title: Text(widget.salesOrderDetailLine.Description + ' - ORDERED : ' + widget.salesOrderDetailLine.QtyOrdered.toString(),
    title: Text(widget.description + ' - QTY : ' + widget.qty.toString(),
      style: TextStyle(fontSize: 15),), //show progress
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


              Navigator.pop(context, {
              'qtyPicked': _qty,

               });






              },
              icon: Icon(
                Icons.done_outline,
                color: Colors.green[400],
                size: 60.0,
              ),
              label: Text('Correct'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                //onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
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




}
