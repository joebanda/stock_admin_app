
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../main.dart';

import '../../../../theme.dart';

import '../../../core/dao/daily_stock_count_dao.dart';
import '../../../core/model/Item.dart';
import '../../../core/model/daily_stock_count.dart';
import '../../../core/model/master_user_model.dart';
import '../../../core/providers/itemsProvider.dart';
import '../../../core/services/Dialogs.dart';
import 'QtyInputPad2.dart';







class ViewVanSalesStock extends StatefulWidget {

final MasterUserModel selectedUser;
ViewVanSalesStock(this.selectedUser);

  @override
  _ViewVanSalesStockState createState() => _ViewVanSalesStockState();
}

class _ViewVanSalesStockState extends State<ViewVanSalesStock> {


  ScrollController _controllerOne;
  Dialogs dialogs = Dialogs();
  Items item;

  List<bool> _selected = List.generate(2000, (i) => false);

  var uuid = Uuid();

  @override
  void initState() {
    super.initState();

    _getVanSalesStock();
    _controllerOne = ScrollController();


  }

  _getVanSalesStock() {

    context.read<ItemsProvider>().getVanSalesStock(widget.selectedUser.id );


  }








  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Items', style: TextStyle(color: Colors.black),),

          actions: [




            SizedBox(width: 40,),
          ],
        ),

        body: Container(

            child: Column(
              children: [


                Expanded(



                    child: context.watch<ItemsProvider>().isSearchingStatus ? Center(child: CircularProgressIndicator(color: drawerBackgroungColor,)) : Container(
                        child: context.watch<ItemsProvider>().itemsList.length >= 0 ?
                        _listViewDataBody(items_List: context.watch<ItemsProvider>().itemsList) :
                        Center(child: Container(width: 250,
                            child: Text('Items not found'))))

                ),

              ],
            )
        )


    );
  }

  _listViewDataBody({@required List<Items> items_List}) {

    ScrollPhysics physics = const BouncingScrollPhysics();
    return Scrollbar(
      controller: _controllerOne,
      isAlwaysShown: true,
      thickness: 15,
      child: ListView.builder(
        controller: _controllerOne,


        itemCount: items_List.length,
        physics: physics,
        //scrollDirection:  Axis.,
        shrinkWrap: true,
        itemBuilder: (context, index) =>Card(
          elevation: 6,

          margin: EdgeInsets.all(10.0),
          child: ListTile(
            tileColor: items_List[index].qtyCounted != '0'?(double.parse(items_List[index].qtyCounted) >= double.parse(items_List[index].qtyInStock) ?(double.parse(items_List[index].qtyInStock) <= double.parse(items_List[index].qtyInStock)
                ? (items_List[index].qtyCounted != '0'? (double.parse(items_List[index].qtyCounted)  > 0 ? Colors.green : null):
            (_selected[index] ? Colors.blue : null) ) : Colors.red):Colors.yellow): null,

            title: Text('${items_List[index].description} Item Code: ${items_List[index].itemCode} '
            ),
            subtitle: Text(  'Barcode: ${items_List[index].barcode} UOM: ${items_List[index].uom} (Qty in System: ${items_List[index].qtyInStock})' ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    // onSurface: Colors.red,
                  ),
                  onPressed: (){

                    },

                  child: Row(
                    children: [


                      Text( 'QTY: ${items_List[index].qtyCounted}',
                        style: TextStyle(color: Colors.black, fontSize: 16),),
                    ],
                  ),
                ),

                Visibility(
                  visible: MyApp.job_role.toUpperCase() == 'FINANCE'|| MyApp.job_role.toUpperCase() == 'ADMIN',
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      // onSurface: Colors.red,
                    ),
                    onPressed: () async {

                      Map result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QtyInputPad2(description: items_List[index].description, qty: double.parse(items_List[index].qtyInStock),)));

                      if(result != null ) {

                        print(result['qtyPicked']);

                        String qtyCount = result['qtyPicked'];

                        String id = uuid.v1().toString();

                        double qty = double.parse(qtyCount);


                        //create daily stock count
                        DailyStockCount count = new DailyStockCount(
                          id: id,
                          id_item : items_List[index].id,
                          id_counted_by: MyApp.authenticatedUser.id == null ? MyApp.authenticatedUser.id : MyApp.authenticatedUser.id,
                          id_sales_person : widget.selectedUser.id == null ? '' : widget.selectedUser.id,
                          id_warehouse : 'id_warehouse',
                          id_deleted_staff :'id_deleted_staff',
                          id_store_branch : 'id_store_branch',
                          id_client : 'id_client',
                          qty_on_system : items_List[index].qtyInStock == null ? 0.00 : double.parse(items_List[index].qtyInStock),
                          qty_actual_count  : qty,
                          bin_number : 'bin_number',
                          item_name : items_List[index].description == null ? '' : items_List[index].description,
                          item_code : items_List[index].itemCode == null ? 'item_code' : items_List[index].itemCode,
                          barcode :items_List[index].barcode == null ? 'barcode' : items_List[index].barcode,
                          uom : items_List[index].uom == null ? 'uom' : items_List[index].uom,
                          reference : 'Van Sales Stock Count',
                          batch_no : 'batch_no',
                          status : 'status',

                        );


                        if(items_List[index].status != 'Counted'){

                          DailyStockCountDAO.addCount(count).then((value) {
                            print('count added $value');

                            if(value == 'success'){

                              setState(() {

                                items_List[index].qtyCounted = qty.toString();
                                //set item status as counted
                                items_List[index].status = 'Counted';
                                //set id of stock count for update count later
                                items_List[index].id_stock_count = id;


                              });
                            }else{
                              print('error');
                              setState(() {
                                items_List[index].qtyCounted = '0';
                              });
                            }

                          });

                        }else{
                          print('already counted');
                          //update the count if already counted
                          DailyStockCountDAO.updateCount( items_List[index].id_stock_count, qty).then((value) {
                            print('UPDATE $value');

                            if(value == 'success'){

                              setState(() {

                                items_List[index].qtyCounted = qty.toString();


                                //set item status as counted
                                items_List[index].status = 'Counted';



                              });
                            }else{
                              print('error');
                              setState(() {
                                items_List[index].qtyCounted = '0';
                              });
                            }

                          });
                        }



                      }

                    },

                    child: Row(
                      children: [
                        Text(''),
                        Tooltip(message:'Verify QTY',
                          child:  Icon(Icons.numbers_outlined, color: Colors.black,),),

                      ],
                    ),
                  ),
                ),





              ],
            ),
            onTap: () async {

              String id = uuid.v1().toString();

              double qty = double.parse(items_List[index].qtyInStock);


                //create daily stock count
              DailyStockCount count = new DailyStockCount(
                id: id,
                id_item : items_List[index].id,
                id_counted_by: MyApp.authenticatedUser.id == null ? MyApp.authenticatedUser.id : MyApp.authenticatedUser.id,
                id_sales_person : widget.selectedUser.id == null ? '' : widget.selectedUser.id,
                id_warehouse : 'id_warehouse',
                id_deleted_staff :'id_deleted_staff',
                id_store_branch : 'id_store_branch',
                id_client : 'id_client',
                qty_on_system : items_List[index].qtyInStock == null ? 0.00 : double.parse(items_List[index].qtyInStock),
                qty_actual_count  : qty,
                bin_number : 'bin_number',
                item_name : items_List[index].description == null ? '' : items_List[index].description,
                item_code : items_List[index].itemCode == null ? 'item_code' : items_List[index].itemCode,
                barcode :items_List[index].barcode == null ? 'barcode' : items_List[index].barcode,
                uom : items_List[index].uom == null ? 'uom' : items_List[index].uom,
                reference : 'Van Sales Stock Count',
                batch_no : 'batch_no',
                status : 'status',

              );


              if(items_List[index].status != 'Counted'){

                DailyStockCountDAO.addCount(count).then((value) {
                  print('count added $value');

                  if(value == 'success'){

                    setState(() {

                      items_List[index].qtyCounted = items_List[index].qtyInStock;


                      //set item status as counted
                      items_List[index].status = 'Counted';
                      //set id of stock count for update count later
                      items_List[index].id_stock_count = id;


                    });
                  }else{
                    print('error');
                    setState(() {
                      items_List[index].qtyCounted = '0';
                    });
                  }

                });

              }else{
                print('already counted');
                //update the count if already counted
                DailyStockCountDAO.updateCount( items_List[index].id_stock_count, qty).then((value) {
                  print('UPDATE $value');

                  if(value == 'success'){

                    setState(() {

                      items_List[index].qtyCounted = items_List[index].qtyInStock;


                      //set item status as counted
                      items_List[index].status = 'Counted';



                    });
                  }else{
                    print('error');
                    setState(() {
                      items_List[index].qtyCounted = '0';
                    });
                  }

                });
              }




            },
            // trailing: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
  }



  Future<String> confirmDialog(BuildContext context) async {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are you sure you want to make this order?'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop('Yes');
                },
              ),
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop('Cancel');
                },
              )
            ],
          );
        });

  }




}







