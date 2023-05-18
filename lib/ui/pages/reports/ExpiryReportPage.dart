import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

import 'package:pdf/pdf.dart';

import 'package:time/time.dart';


import '../../../core/dao/ItemsDAO.dart';
import '../../../core/dao/stocktake_count_dao.dart';
import '../../../core/dao/store_branch_dao.dart';
import '../../../core/enums/ReportType.dart';
import '../../../core/model/Item.dart';
import '../../../core/model/StoreBranch.dart';
import '../../../core/model/stocktake_count.dart';
import '../../../core/model/supplier.dart';
import '../../../core/services/Api.dart';

import '../../../main.dart';
import '../stock_take/QtyInputPad.dart';
import '../stock_take/loading.dart';
//import 'preview_pdf_page.dart';
import 'report.dart';

class ExpiryReportPage extends StatefulWidget {
  const ExpiryReportPage({Key key, this.client, this.storeBranch, @required this.reportType}) : super(key: key);

  final Supplier client;
  final String title = 'Expiry Report';
  final StoreBranch storeBranch;
  final ReportType reportType;

  @override
  _ExpiryReportPageState createState() => _ExpiryReportPageState();
}

class _ExpiryReportPageState extends State<ExpiryReportPage> {
  List<StocktakeCount> _salesLinesList;
  List<StoreBranch> _storeBranches;
  Map<StocktakeCount,StoreBranch> countToBranch;
  List<String> _jobTitles = ['ADMIN','ACCOUNTS','MANAGER','SUPERVISOR'];
  //LocalStorageService _localStorageService = locator<LocalStorageService>();
  String _titleProgress = 'Expiry Report';
  List<String> _menuOptions = [
    // 'Print',
    'Share'];
  int _iconIndex = 0;
  final List<IconData> _menuIcons = [Icons.print,Icons.share_rounded];

  final df = new DateFormat('dd-MMM-yyyy');

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  @override
  void initState() {
    super.initState();
    _salesLinesList = [];
    _titleProgress = widget.title;
    _storeBranches = [];
    countToBranch={};
    widget.reportType==ReportType.LineItemsReport
        ? _getSalesLinesByClientId(widget.client.idsupplier)
        : _getSalesLinesByStoreBranch(widget.storeBranch.id);

  }


  _getSalesLinesByClientId(String id_client) async{
    _showProgress('Loading reports...');
    await Api.getStockTakeCountByClientId(id_client: id_client).then((e) {
      //print('Loading ...............');
      //print(e.length);
      setState(() {
        _salesLinesList = e;
      });
      _showProgress('Expiry Report');
    });
    _storeBranches= await StoreBranchDAO.getStoreBranches();
    _salesLinesList.forEach((salesLine) {
    if(salesLine.id_store_branch!=null) {
      print('Salesline store branch id: ${salesLine.id_store_branch}');
      setState(() {
        countToBranch[salesLine] = _storeBranches
            .singleWhere((branch) => salesLine.id_store_branch == branch.id);
      });

      print('Added ${countToBranch[salesLine].storeBranchName} to count to branch');
      }else{

      }
    });
    print('Count to Branch length:${countToBranch.length}');

    // print('Store branch name: ${_storeBranch.storeBranchName}');

  }

  _getSalesLinesByStoreBranch(String id_store_branch) async{
    _showProgress('Loading reports...');
    Api.getStockTakeCountByStoreBranchId(id_store_branch: id_store_branch).then((e) {
      //print('Loading ...............');
      //print(e.length);
      setState(() {
        _salesLinesList = e;
      });
      _showProgress('Expiry Report');
    });

    // _storeBranches= await Api.getStoreBranches();

    // print('Store branch name: ${_storeBranch.storeBranchName}');

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
                              StocktakeCountDAO.updateAsDeleted(selectedItem.id,  MyApp.id_autheticated_user).then((result) {
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
                    'false', 'false','false' )),
      );

      String qtyCount = result['qtyPicked'];
      String expiryDate = result['expiryDate'];
      String binNumber = result['binNumber'];
      String rateOfSales = result['ros'].toString();

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
                         // color: Color(0xFF262AAA),
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
              //width: 100,
             // height: 100,
              decoration: BoxDecoration(
                /*color:  DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+4.weeks)
                    ? Colors.red[300]
                    : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+8.weeks)
                    ? Colors.amber[400]
                    : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+12.weeks)
                    ? Colors.green[400]
                    : Colors.grey,*/

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
                //leading: Icon(Icons.delete, size: 45,),

              leading: salesLine.date_expiry.toString() ==  'null' ? null: DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now())
                  ? Icon(Icons.delete, size: 45, color: Colors.red,)
                  : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+4.weeks)
                  ? Icon(Icons.whatshot, size: 45,color: Colors.orange,)
                  : DateTime.parse(salesLine.date_expiry).isBefore(DateTime.now()+12.weeks)
                  ? Icon(Icons.widgets_rounded, size: 45, color: Colors.blue,)
                  : Icon(Icons.widgets_rounded, size: 45, color: Colors.green,),

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

                title: Text(salesLine.description,
                  style: TextStyle(
                      color:  Colors.black),),
                subtitle: Text('${salesLine.date_expiry.toString() ==  'null' ? '' :'Exp: '+df.format(DateTime.parse(salesLine.date_expiry))}QTY: ${salesLine.qty}\nLocation: ${widget.reportType==ReportType.LocationReport
                    ? widget.storeBranch.storeBranchName
                    : countToBranch[salesLine]!=null ? countToBranch[salesLine].storeBranchName : ''}',
                    //style: TextStyle(
                    //color:  Colors.white),
                ),
                isThreeLine: true,
                trailing: !_jobTitles.contains(MyApp.job_role.toString().toLowerCase()) ? null : Container(
                  width: 80,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                          child: Text('Qty: ${salesLine.qty}')),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                icon:Icon(Icons.edit),
                                onPressed:(){
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
                    ],
                  ),
                ),

              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF262AAA),
        title: Text(_titleProgress, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          PopupMenuButton<String>(
              color: Colors.white,
              icon: Icon(Icons.more_vert_rounded,color: Colors.white,),
              onSelected: (String choice)async{

               // print(widget.storeBranch.storeBranchName);

                //print('_salesLinesList '+ _salesLinesList.length.toString());

              //  print('countToBranch '+ countToBranch.length.toString());


                switch(choice){
                  case 'Print':


                    break;
                  case 'Share':

                    //TODO print
                   /* Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PdfPreviewPage(
                                  isDraft: false,
                                  // allowPrinting: true,
                                  // allowSharing: true,
                                  pdfFileName: 'Expiry_Report_${DateTime.now()}.pdf',
                                  // salesHeader: widget.salesHeader,
                                  orderDate: DateTime.now(),
                                  salesLinesList: _salesLinesList,
                                  invoiceDate: DateTime.now(),
                                  layoutBuild: (_) =>
                                      generatePdfExpiryReport(
                                        PdfPageFormat.a4,
                                        salesLinesList: _salesLinesList,
                                        //countToBranchMap: countToBranch,
                                        location: widget.storeBranch?.storeBranchName==null ? '' : widget.storeBranch.storeBranchName,
                                        isDraft: false,
                                      ),
                                )
                          //       BluetoothPrintApp(
                          //         salesHeader: widget.salesHeader,
                          //         salesLinesList: salesLineList,
                          //         orderDate: widget.salesHeader.orderDate,
                          //       invoiceDate: DateTime.now(),)
                          //     )
                        ));*/
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return _menuOptions.map((String choice) {
                  switch(choice){
                    case 'Print':
                      _iconIndex = 0;
                      break;
                    case 'Share':
                      _iconIndex = 1;
                      break;

                  }
                  return PopupMenuItem<String>(
                    key: Key('Share'),
                    value: choice,
                    child: Row(
                      children: [
                        Icon(_menuIcons[_iconIndex],),
                        SizedBox(width: 6,),
                        Text(choice,style: TextStyle(),),
                      ],
                    ),
                  );
                }).toList();
              }
          ),

        ],
        leading: BackButton(color: Colors.white,),
      ),

      body: Container(
        child: _listViewDataBody(salesLines: _salesLinesList),
      ),
    );
  }
}
