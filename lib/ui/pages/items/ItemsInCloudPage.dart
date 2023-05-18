
import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';





import 'package:provider/provider.dart';


import '../../../core/dao/ItemsDAO.dart';

import '../../../core/model/Item.dart';


import '../../../core/providers/itemsProvider.dart';
import '../../../core/services/Api.dart';
import '../../../core/services/AppLists.dart';
import '../../../core/services/Dialogs.dart';
import '../../../core/services/Strings.dart';
import '../../../main.dart';


import '../../../theme.dart';
import 'item_price_lists_page.dart';







class ItemsInCloudPage extends StatefulWidget {


  const ItemsInCloudPage({Key key}) : super(key: key);

  @override
  ItemsInCloudPageState createState() => ItemsInCloudPageState();
}

class ItemsInCloudPageState extends State<ItemsInCloudPage> {


  String _searchByString = 'SEARCH BY NAME';

  ScrollController _controllerOne;


  File  itemImage;


  final Api _api = Api();
  Dialogs dialogs = Dialogs();




  bool isSearching = false;
  bool getNewItems = false;
  bool updateItems = false;
  bool searchByBarcode = false;

  List<CustomPopupMenu> choices = <CustomPopupMenu>[

    CustomPopupMenu(
        title: 'Edit',
        icon: FontAwesomeIcons.fileEdit,
        icon_color: Colors.black
    ),
    CustomPopupMenu(
        title: 'Delete Item',
        icon: FontAwesomeIcons.trash,
        icon_color: Colors.red
    ),


  ];


  Uint8List webImage = Uint8List(8) ;




  @override
  void initState() {
    super.initState();

    _getItemsFromCloud();
    _controllerOne = ScrollController();


  }

  _getItemsFromCloud() {
    context.read<ItemsProvider>().getItemsList();
  }







  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Row(
          children: [


            SizedBox( width: 200, height: 30.0,

                //add text field border decoration
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              width: 250,

              alignment: Alignment.centerLeft,
             // color: Colors.black12,
              child: TextField(
                cursorColor: Colors.black,


                onChanged: (value) {

                  if(_searchByString == 'SEARCH BY NAME') {
                    context.read<ItemsProvider>().SearchByName(value);
                  }else
                  if(_searchByString == 'SEARCH BY BARCODE') {
                    context.read<ItemsProvider>().SearchByBarcode(value);

                  }else  if(_searchByString == 'SEARCH BY ITEM CODE') {
                    context.read<ItemsProvider>().SearchByItemCode(value);
                  }

                  },
                decoration: textfieldInputDecoration('Search'),
              ),
            )),

          ],
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: ()=> context.read<ItemsProvider>().getItemsList(),
            /*onPressed: () {

              Expanded(
                child: Container(child: _itemsList.length == 0 ? Center(child: CircularProgressIndicator()) : Container(
                    child: _listViewDataBody(items_List: _itemsList))),
              );

            }*/
          ),






          const SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children: [

          Expanded(



              child: context.watch<ItemsProvider>().isSearchingStatus ? Center(child: CircularProgressIndicator(color: drawerBackgroungColor,)) : Container(
                  child: context.watch<ItemsProvider>().itemsList.length >= 0 ?
                  _listViewDataBody(items_List: context.watch<ItemsProvider>().itemsList) :
                  const Center(child: SizedBox(width: 250,
                      child: Text('Items not found'))))

          ),

        ],
      )


    );
  }

  _listViewDataBody({@required List<Items> items_List}) {
    //Scroll both Vertical and Horizontal
    ScrollPhysics physics = const BouncingScrollPhysics();
    return Scrollbar(
      controller: _controllerOne,
      isAlwaysShown: true,
      thickness: 15,
      child: ListView.builder(
        controller: _controllerOne,
        itemCount: items_List.length,
        physics: physics,
        shrinkWrap: true,
        itemBuilder: (context, index) =>Card(
          elevation: 6,

          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(


             child: CachedNetworkImage(

                 imageUrl: '${AppStrings.ROOT}/images/${MyApp.db_name}/${items_List[index].imageUrl}',

                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => itemImage!=null
                      ? Image.file(itemImage,)
                      : Container()
              )

            ),
            title: Text('${items_List[index].description}   Item Code: ${items_List[index].itemCode} '
            ),
            subtitle: Text(  'Barcode: ${items_List[index].barcode}  UOM: ${items_List[index].uom}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [





                MyApp.authenticatedUser.job_role.toUpperCase() =='ADMIN' ? PopupMenuButton<CustomPopupMenu>(
                  icon: const Icon(Icons.more_vert_rounded,color: Colors.black,),
                  tooltip: 'More Actions',
                  onSelected: (value)async{
                    switch(value.title){

                      case 'Edit':


                        break;
                      case 'Delete Item':

                        //show delete confirmation dialog
                        await dialogs.confirm(context, 'Delete Item', 'Are you sure you want to delete ${items_List[index].description} ?').then((value) async{


                          if(value){



                            await ItemsDAO.deleteItem(id: items_List[index].id).then((value) {
                              if(value=='success') {

                                //refresh the list
                                context.read<ItemsProvider>().getItemsList();

                                //dialogs.information(context, "Delete Done", "Item deleted",);
                              }else{
                                //print(result);
                                dialogs.information(context, "Delete Error", "Sorry Error Deleting ${items_List[index].description}",);
                              }
                            });
                          }
                        });
                        break;



                    }
                  },
                  itemBuilder: (context){
                    return choices.map((e) => PopupMenuItem<CustomPopupMenu>(
                      value: e,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            e.icon,
                            color: e.icon_color,
                          ),
                          SizedBox(width: 20.0,),
                          Text(e.title),

                        ],
                      ),

                    )).toList();
                  },
                ): Container()

              ],
            ),
            onTap: () async {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPriceListsPage(itemSelected: items_List[index],)));
            },
            // trailing: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
  }



}

class CustomPopupMenu {
  CustomPopupMenu({
    this.title,
    this.icon,
    this.icon_color
  });
  String title;
  IconData icon;
  Color icon_color;
}



