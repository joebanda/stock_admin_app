//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


import 'package:time/time.dart';
import 'package:uuid/uuid.dart';

import '../../../core/dao/ItemsDAO.dart';
import '../../../core/dao/stocktake_count_dao.dart';
import '../../../core/dao/store_branch_dao.dart';
import '../../../core/model/Item.dart';
import '../../../core/model/StoreBranch.dart';
import '../../../core/model/stocktake_count.dart';
import '../../../core/model/stocktake_task.dart';
import '../../../core/services/Api.dart';
import '../../../core/services/LocationService.dart';

import '../../../main.dart';
import 'QtyInputPad.dart';
import 'loading.dart';

class StockCountLineTable extends StatefulWidget {

  StocktakeTask stocktakeTask;
  StockCountLineTable(this.stocktakeTask);
  final String title = 'Stock Count';

  @override
  StockCountLineTableState createState() => StockCountLineTableState();
}

class StockCountLineTableState extends State<StockCountLineTable> {
  List<StocktakeCount> _salesLinesList;
  List<StocktakeCount> _salesLinesFoundList;
  TextEditingController _barcodeController;
  StoreBranch _storeBranch;
  //LocalStorageService _localStorageService = locator<LocalStorageService>();
  List<String> _jobTitles = ['admin','supervisor','field supervisor'];

  String result = "Hey there";
  String _titleProgress;


  //ScanResult scanResult;
  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  //LocalStorageService _storageService = locator<LocalStorageService>();

  //static final _possibleFormats = BarcodeFormat.values.toList()
  //  ..removeWhere((e) => e == BarcodeFormat.unknown);

  //List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();
    _salesLinesList = [];
    _salesLinesFoundList = [];
    _barcodeController = new TextEditingController();
    _titleProgress = widget.title;
    _storeBranch = StoreBranch();


    _getSalesLines(widget.stocktakeTask);
  }

  //Method to update progress in AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getSalesLines(StocktakeTask stocktakeTask) async{
    _showProgress('Loading Stock Count...');
    StocktakeCountDAO.getById(stocktakeTask.id,'date_created').then((e) {
      //print('Loading ...............');
      //print(e.length);
      setState(() {
        _salesLinesList = e;
      });
      _showProgress(widget.stocktakeTask.store_branch_name);
    });

   _storeBranch= await StoreBranchDAO.getStoreBranch(stocktakeTask.id_store_branch);
    //print('Store branch name: ${_storeBranch.storeBranchName}');

  }

  _deleteItem( StocktakeCount selectedItem) {
    showDialog(context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 220,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(selectedItem.description.toString(),style: TextStyle(fontSize: 10),),
                    Text('Barcode : '+selectedItem.barcode.toString(),style: TextStyle(fontSize: 10),),
                    Text('QTY Counted : '+selectedItem.qty.toString(),style: TextStyle(fontSize: 10),),
                    selectedItem.rate_of_sale.toString() != 'null' ? Text('ROS : '+selectedItem.rate_of_sale.toString(),style: TextStyle(fontSize: 10),):Container(),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [

                        SizedBox(
                          width: 100.0,
                          child: ElevatedButton(
                            //color: Colors.grey,
                            onPressed: (){

                              Navigator.of(context, rootNavigator: true)
                                  .pop();



                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 100.0,
                          child: ElevatedButton(
                            //color: Color(0xFF262AAA),
                            onPressed: (){

                              Navigator.of(context, rootNavigator: true).pop();

                              _showProgress('deleting item...');
                              StocktakeCountDAO.updateAsDeleted(selectedItem.id,  MyApp.id_autheticated_user,).then((result) {
                                if ('success' == result) {


                                  setState(() {


                                    _salesLinesList.removeWhere((element) => element.id == selectedItem.id);


                                  });

                                }
                              });

                            },
                            child: Text(
                              'Delete ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );

  }

  //Create a DataTable snd show the employees
  SingleChildScrollView _dataBody() {
    //Scroll both Vertical and Horizontal
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: FittedBox(
          child: DataTable(
            columns: [
              DataColumn(
                label: Text('ITEM'),
              ),
              DataColumn(
                label: Text('EXPIRY DATE'),
              ),
              DataColumn(
                label: Text('QTY '),
              ),
           /*   DataColumn(
                label: Text('Remove'),
              ),*/
            ],
            dataRowHeight: 40,
            rows: _salesLinesList
                .map(
                  (salesline) => DataRow(cells: [
                    DataCell(
                      Text(salesline.description.toUpperCase()),
                      onTap: () {
                        _deleteItem(salesline);
                      },
                    ),
                    DataCell(
                      Text(salesline.date_expiry.toString()),
                      onTap: () {
                        _deleteItem(salesline);
                      },
                    ),
                    DataCell(
                      Text(salesline.qty.toString()),
                      onTap: () {
                        _deleteItem(salesline);
                      },
                    ),

                  ]),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  ListView _listViewDataBody({@required List<StocktakeCount> salesLines}) {
    //Scroll both Vertical and Horizontal
    return ListView.builder(
        itemCount: salesLines.length,
        itemBuilder: (BuildContext context,index){
          StocktakeCount salesLine = salesLines[index];
          return TextButton(
            onPressed: () {
            },
            child: Container(

              decoration: BoxDecoration(


                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: ListTile(

                leading: salesLine.date_expiry.toString() ==  'null' ? null: DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now())
                    ? Icon(Icons.delete, size: 45, color: Colors.red,)
                    : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+4.weeks)
                    ? Icon(Icons.whatshot, size: 45,color: Colors.orange,)
                    : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+12.weeks)
                    ? Icon(Icons.widgets_rounded, size: 45, color: Colors.blue,)
                    : Icon(Icons.widgets_rounded, size: 45, color: Colors.green,),

                title: Text(salesLine.description,
                  style: TextStyle(
                      color:  Colors.black),),
                subtitle: Text('${salesLine.date_expiry.toString() ==  'null' ? '' :'Exp: '+ DateFormat.yMMMd().format(DateTime.parse(salesLine.date_expiry))}\nQty: ${salesLine.qty}'),
                isThreeLine: true,
                trailing: !_jobTitles.contains(MyApp.job_role.toString().toLowerCase()) ? null : Container(
                  width: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          icon:Icon(Icons.edit),
                          onPressed:()async{
                            print('Edit tapped');
                            updateQty(salesLine);
                          },
                          tooltip: 'Edit',
                        ),
                      ),
                      SizedBox(width: 2,),
                      Expanded(
                        child: IconButton(
                          icon:Icon(Icons.delete),
                          onPressed:(){
                            _deleteItem(salesLine);
                          },
                          tooltip: 'Delete',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusScope.of(context).requestFocus(_focusNodebarcode);
        /* FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }*/
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.stocktakeTask.store_branch_name,
            style: TextStyle(fontSize: 12)),
          /*title: TextField(
            autofocus: true,
            showCursor: true,
            focusNode: _focusNodebarcode,
            controller: _barcodeController,

            //readOnly: true,

            // onEditingComplete: (() => focusNode.requestFocus()),
            onChanged: (value) => searchForItem(value),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: widget.stocktakeTask.branch_name,
                hintStyle: TextStyle(color: Colors.white)),
          ), //show progress*/
          actions: <Widget>[
  /*          IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _barcodeController.text = '';
                // _getSalesLines(orderId);
              },
            ),*/
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //TODO Show input dialog
                _barcodeController.text = '';
                showDialog(context: context,
                  builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 200,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Barcode Number'
                                           ),
                              controller: _barcodeController,
                            ),
                            SizedBox(
                              width: 320.0,
                              child: ElevatedButton(
                                //color: Color(0xFF1BC0C5),
                                onPressed: (){
                                  //searchForItem('7622210933942');
                                  if(_barcodeController.text.toString()!='') {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    searchForItem(
                                        _barcodeController.text.toString());

                                  }
                                  //Navigator.pop(context);
                                },
                                child: Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  }
                );

              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(),
              Expanded(
                // child: _dataBody(),
                child: _listViewDataBody(salesLines: _salesLinesList),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xFF262AAA),
            onPressed: () async {


             if (_storeBranch.latitude!=null &&_storeBranch.longtitude!=null
             && _storeBranch.latitude!="" &&_storeBranch.longtitude!="") {

               Position currentPosition = await LocationService.getCurrentLocation(context);
               double difference = LocationService.calculateStoreBranchDistance(currentPosition.latitude, currentPosition.longitude,
                 double.parse(_storeBranch.latitude), double.parse(_storeBranch.longtitude));
               print('Store Branch Difference: $difference');
                if(currentPosition!=null) {
                  //if difference is less than 1KM
                  //TODO change to variable
                  //Location
                  if(difference < 500){
                    //scan barcode
                    await _scanBarcode().then((value) async {
                      print('SCANNED BARCODE: $value');
                      // Fluttertoast.showToast(msg: 'SCANNED BARCODE: $value');
                      // value='6009188000349';
                      if (value.toString() == '' ||value.toString()=='-1') {
                        print('xxX Barcode scan cancelled Xxx');
                      } else {
                        searchForItem(value);
                        // searchForItem('6009188000349');
                      }
                    });
                  }else{
                    print('Distance to store branch is greater than 1KM can not open camera');
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: Row(
                        children: [
                          Expanded(child: Icon(Icons.wrong_location,color: Colors.red,)),
                          Expanded(
                              flex: 3,
                              child: Text('Out of Range')),
                        ],
                      ),
                      content: Text('You\'re not within location of this store branch.'),

                    ));
                  }
                }
             }else{

               await _scanBarcode().then((value) async {
                 print('SCANNED BARCODE: $value');
                 // Fluttertoast.showToast(msg: 'SCANNED BARCODE: $value');
                 // value='6009188000349';
                 if (value.toString() == '' ||value.toString()=='-1') {
                   print('xxX Barcode scan cancelled Xxx');
                 } else {
                   searchForItem(value);
                   // searchForItem('6009188000349');
                 }
               });
             /*  showDialog(context: context, builder: (context)=>AlertDialog(
                 title: Row(
                   children: [
                     Expanded(child: Icon(Icons.wrong_location,color: Colors.red,)),
                     Expanded(
                         flex: 3,
                         child: Text('Location Error')),
                   ],
                 ),
                 content: Text('Location details not set for selected store. Please see admin.'),

               ));*/

             }

            },
            child: Icon(
                Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

/*  Future<String> _scanBarcode() async {
    String barcodeToScan;
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      barcodeToScan = qrResult.rawContent;
    } catch (Exception) {}

    return barcodeToScan;
  }*/

  Future<String> _scanBarcode() async {
    String barcodeToScan;
    try {
      // var options = ScanOptions(
      //   strings: {
      //     "cancel": 'Cancel',
      //     "flash_on": 'Flash On',
      //     "flash_off": 'Flash Off',
      //   },
      //   restrictFormat: selectedFormats,
      //   useCamera: _selectedCamera,
      //   autoEnableFlash: _autoEnableFlash,
      //   android: AndroidOptions(
      //     aspectTolerance: _aspectTolerance,
      //     useAutoFocus: _useAutoFocus,
      //   ),
      // );
      //
      // var result = await BarcodeScanner.scan(options: options);
      // barcodeToScan = result.rawContent;
      //
      // setState(() => scanResult = result);

      barcodeToScan = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException catch (e) {
      // var result = ScanResult(
      //   type: ResultType.Error,
      //   format: BarcodeFormat.unknown,
      // );
      //
      // if (e.code == BarcodeScanner.cameraAccessDenied) {
      //   setState(() {
      //     result.rawContent = 'The user did not grant the camera permission!';
      //   });
      // } else {
      //   result.rawContent = 'Unknown error: $e';
      // }
      // setState(() {
      //   scanResult = result;
      // });

    }
    return barcodeToScan;
  }

  searchForItem(String barcode) async {
    print('Searching for barcode:$barcode');
   /* print('OOOOOOOOOOOOOOOOOOOOOOOO');
    print(barcode);
    print(Loading.itemsList.length);
    print('OOOOOOOOOOOOOOOOOOOOOOOO');*/

    print('Items List length:${Loading.itemsList.length}');

    if(Loading.itemsList.length < 2) {
      _showProgress('Loading items...');
      Fluttertoast.showToast(msg: 'Searching for item barcode:$barcode',toastLength: Toast.LENGTH_LONG);
      Loading.itemsList = await ItemsDAO.getItemsByBarcode(barcode);
      _showProgress(widget.stocktakeTask.store_branch_name);

    }

    List<Items> itemInlist =Loading.itemsList
        .where((element) => element.barcode.contains(barcode))
        .toList();

   // print(itemInlist[0].Description);
    //print('Items in list length:${itemInlist.length}');

    if (itemInlist.length > 0) {
      dynamic result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                QtyInputPad(itemInlist[0].description.toUpperCase(),widget.stocktakeTask.include_expiry_date,
                    widget.stocktakeTask.count_by_bins, widget.stocktakeTask.include_rate_of_sales, widget.stocktakeTask.includeBatchNo )),
      );

      String qtyCount = result['qtyPicked'];
      String expiryDate = result['expiryDate'];
      String binNumber = result['binNumber'];
      String rateOfSales = result['ros'].toString();
      String batch_no = result['batch_no'];





      String stockCount_id = Uuid().v1();





      StocktakeCountDAO.addObject( stockCount_id, widget.stocktakeTask.id, itemInlist[0].id,  MyApp.id_autheticated_user,qtyCount,binNumber,rateOfSales, expiryDate,
          itemInlist[0].description, barcode,   widget.stocktakeTask.reference,_storeBranch.id, itemInlist[0].idClient, batch_no ).then((value) {

            print(value);
            if(value== 'success'){

              //add to list for display
            StocktakeCount st = StocktakeCount();
            st.id = stockCount_id;
            st.qty =  qtyCount;
            st.description = itemInlist[0].description.toUpperCase();
            //st.uom = itemInlist[0].uom.toString();
            st.barcode = itemInlist[0].barcode.toString();
            if(expiryDate != 'null') {
              DateTime exDate = DateTime.parse(expiryDate);
              // st.date_expiry = DateFormat.yMMMd().format(exDate);
              st.date_expiry = exDate.toString();
            }
            st.rate_of_sale = rateOfSales;
            st.id_store_branch = _storeBranch.id;




          setState(() {

            _salesLinesList.add(st);

              });

            }
      }
      );




    }else{

      showDialog(context: context,
          builder: (context){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Item Not Found'),
                      SizedBox(
                        width: 320.0,
                        child: ElevatedButton(
                          //color: Color(0xFF262AAA),
                          onPressed: (){


                              Navigator.of(context, rootNavigator: true)
                                  .pop();

                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      );
    }

  }

  updateQty(StocktakeCount count) async {
    print('UpdateQty Searching for barcode:${count.barcode}');
    /* print('OOOOOOOOOOOOOOOOOOOOOOOO');
    print(barcode);
    print(Loading.itemsList.length);
    print('OOOOOOOOOOOOOOOOOOOOOOOO');*/

    print('Items List length:${Loading.itemsList.length}');
    if(Loading.itemsList.length < 2) {
      Fluttertoast.showToast(msg: 'Searching for item barcode:${count.barcode}',toastLength: Toast.LENGTH_LONG);
      Loading.itemsList = await ItemsDAO.getItemsByBarcode(count.barcode);
    }
    List<Items> itemInlist =Loading.itemsList
        .where((element) => element.barcode.contains(count.barcode))
        .toList();

    // print(itemInlist[0].Description);
    print('Items in list length:${itemInlist.length}');

    if (itemInlist.length > 0) {
      dynamic result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                QtyInputPad(itemInlist[0].description.toUpperCase(),'false',
                    widget.stocktakeTask.count_by_bins, 'false' , 'false')),
      );

      String qtyCount = result['qtyPicked'];
      String expiryDate = result['expiryDate'];
      String binNumber = result['binNumber'];
      String rateOfSales = result['ros'].toString();
      String batch_no = result['batch_no'];

      print('FFFFFFFFFFFFFFFFFFF ${rateOfSales}');

      // String stockCount_id = Uuid().v1();


      Api.updateQty(count.id, qtyCount).then((value) {
        print(value);
        if(value== 'success'){
          Fluttertoast.showToast(msg: 'Successfully updated qty');
          setState(() {
            // print('Qty set to $qtyCount');
            count.qty = qtyCount;
          });
          //add to list for display

          // StocktakeCount st = StocktakeCount();
          // st.id = stockCount_id;
          // st.qty =  qtyCount;
          // st.description = itemInlist[0].description.toUpperCase();
          // st.uom = itemInlist[0].uom.toString();
          // st.barcode = itemInlist[0].barcode.toString();
          // if(expiryDate != 'null') {
          //   DateTime exDate = DateTime.parse(expiryDate);
          //   // st.date_expiry = DateFormat.yMMMd().format(exDate);
          //   st.date_expiry = exDate.toString();
          // }
          // st.rate_of_sale = rateOfSales;
          // st.id_store_branch = _storeBranch.id;
          //
          // setState(() {
          //   _salesLinesList.add(st);
          // });

        }else{
          Fluttertoast.showToast(msg: 'Update qty failed');
        }
      }
      );




    }else{

      showDialog(context: context,
          builder: (context){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Item Not Found'),
                      SizedBox(
                        width: 320.0,
                        child: ElevatedButton(
                          //color: Color(0xFF262AAA),
                          onPressed: (){


                            Navigator.of(context, rootNavigator: true)
                                .pop();

                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      );
    }

  }

}





