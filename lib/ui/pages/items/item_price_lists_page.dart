import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../../theme.dart';
import '../../../core/dao/PriceListDAO.dart';
import '../../../core/model/Item.dart';
import '../../../core/model/price_list.dart';
import '../../../core/providers/price_list_provider.dart';


class ItemPriceListsPage extends StatefulWidget {

  final Items itemSelected;
  const ItemPriceListsPage({Key key, @required  this.itemSelected}) : super(key: key);

  @override
  State<ItemPriceListsPage> createState() => _ItemPriceListsPageState();
}

class _ItemPriceListsPageState extends State<ItemPriceListsPage> {

  ScrollController _controllerOne;
  NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
  String _selectedItemId ;


  @override
  void initState() {

    super.initState();

    _controllerOne = ScrollController();

    _selectedItemId = widget.itemSelected.id;

    //print(_selectedItemId);
    _getPriceListsByItem(widget.itemSelected.id);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          children: [
            Container(
              //width: 265, height: 30.0,

              child: Text('${widget.itemSelected.description} '
                , style: TextStyle(color: Colors.white, fontSize: 15),),

            ),
            SizedBox(width: 10,),
          ],
        ),

        actions: [

          IconButton(
            tooltip: 'Set Price',
            style: TextButton.styleFrom(
              primary: Colors.black,

            ),
            icon: Icon(Icons.monetization_on_outlined, color: Colors.white,),
            onPressed: (){
              //showEasyDialog(context, title: 'Add to Price List', child: ItemToPriceListStepper(selectedItem: widget.itemSelected), height: 450);

            },

          ),




        ],
      ),
      body: Container(

          child: Column(
            children: [
              Expanded(
                  child: context.watch<PriceListProvider>().isSearchingStatus ? Center(child: CircularProgressIndicator(color: drawerBackgroungColor,)) : Container(
                      child: context.watch<PriceListProvider>().priceListsByItemList.length >= 0 ?
                      _listViewDataBody(items_List: context.watch<PriceListProvider>().priceListsByItemList) :
                      Center(child: Container(width: 250,
                          child: Text('Items not found'))))
              ),
            ],
          )
      ),
    );
  }

  _listViewDataBody({@required List<PriceList> items_List}) {
    //Scroll both Vertical and Horizontal
    //ScrollPhysics physics = const BouncingScrollPhysics();
    return Scrollbar(
      controller: _controllerOne,
      isAlwaysShown: true,
      thickness: 15,
      child: ListView.builder(
        controller: _controllerOne,
        itemCount: items_List.length,
        //physics: physics,
        //shrinkWrap: true,
        itemBuilder: (context, index) =>Card(
          elevation: 6,
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            tileColor: items_List[index].isPromoPrice == 'true' ? Colors.green : Colors.white,


            title: Text('${items_List[index].priceListName.toUpperCase()}  ${items_List[index].currencySymbol}${numberFormat.format(double.parse(items_List[index].isTaxable))}'),
           //subtitle: Text('${widget.itemSelected.uom}'),
           //TODO show date last updated as subtitle
           // subtitle: Text('${items_List[index].description} '),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    // onSurface: Colors.red,
                  ),
                  onPressed: (){

                    UpdatePriceDialog(context).then((value) {

                     // print('XXXXXX $value');

                      if(value != 'cancel'){



                    PriceListDAO.updateItemPrice( id_item : widget.itemSelected.id, id_price_list: items_List[index].id, new_price: value).then((value) {

                      if(value == 'success'){
                        _getPriceListsByItem(widget.itemSelected.id);
                      }else{
                        print('error');
                      }


                    });


                      }



                    } );
                    },
                  child: Row(
                    children: [
                      Text(''),
                      Tooltip(message:  'Update Price',
                          child: Icon(Icons.edit,
                              color:  Colors.black)),
                    ],
                  ),
                ),

                //TODO create audit trail for price change

                //TODO delete item from price list
             /*   TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    // onSurface: Colors.red,
                  ),
                  onPressed: (){

                  },
                  child: Row(
                    children: [
                      Text(''),
                      Tooltip(message:  'Remove from price list',
                          child: Icon(Icons.cancel_outlined,
                              color:  Colors.red)),
                    ],
                  ),
                ),*/
              ],
            ),
            onTap: () async {

            },
            // trailing: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
  }



  Future<void> _getPriceListsByItem(String id_item) async {

    await   context.read<PriceListProvider>().getPriceListsByItem(id_item);


  }
}


  Future<String> UpdatePriceDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    // customController.text = barcodeNo;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
             title: Text('Enter New Price'),
            content: Container(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],
                decoration: InputDecoration(
                    labelText: 'New Price',
                    hintText: 'Enter New Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Update Price'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop('Cancel');
                },
              )
            ],
          );
        });
  }



