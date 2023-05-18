

import 'package:flutter/material.dart';



import '../dao/ItemsCloudDAO.dart';
import '../dao/ItemsDAO.dart';
import '../model/Item.dart';

class ItemsProvider with ChangeNotifier{

  List<Items> _itemsList =[];
  List<Items> _fullItemsList =[];

  List<Items> _allItems = [];
  //List<Items> _itemsInPriceList = [];
  List<Items> _itemsNotInPriceList = [];

  bool isSearching = false;

  List get itemsList => _itemsList;
  List get fullItemsList => _fullItemsList;

  List get itemsNotInPriceList => _itemsNotInPriceList;
  //List get itemsInPriceList => _itemsInPriceList;

  bool get isSearchingStatus => isSearching;

  void getItemsList(){

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    ItemsCloudDAO.getAllItemsList().then((items) {

      isSearching = false;

      _itemsList = _fullItemsList =   items;

     notifyListeners();

    });

  }

  void getItemsListByCategory(String searchCategory){

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    ItemsCloudDAO.getItemsByCategory(searchCategory).then((items) {

      isSearching = false;

      _itemsList =  items;

      notifyListeners();

    });

  }

  Future<void> getItemsNotInPriceList(String id_price_list) async {

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    ItemsCloudDAO.getItemsInPriceList(id_price_list).then((items) {

      isSearching = false;



      ItemsCloudDAO.getAllItemsList().then((value) async {


        print('Value 1 '+value.length.toString());

       // await value.removeWhere((element) => items.contains(element));



        if(value.length>0) {
          var totalcount = 0;
          for (int i = 0; i < items.length; i++) {
            for (int j = 0; j < value.length; j++) {
                //print(items[i].description + " index $i Found" + " == index $j Found" + value[j].description);
              if (items[i].id.toLowerCase().trim() == value[j].id.toLowerCase().trim()) {
                print(items[i].description);
               // print(items[i].id + " " + " == " + value[j].id);

                items.removeAt(i);
                value.removeAt(j);
                i= 0;
                j =0;

                break;
              }
            }
          }
        }
        print('Value 2 '+value.length.toString());

        //_itemsNotInPriceList = _fullItemsList =   items;
        _itemsNotInPriceList = _fullItemsList =   value;
        notifyListeners();

      });







    });

   // _itemsNotInPriceList = await ItemsCloudDAO.getItemsInPriceList(id_price_list).then((value) => null);

   //_itemsInPriceList = await ItemsCloudDAO.getItemsInPriceList(id_price_list).then((value) => null);

   //_allItems = await  ItemsCloudDAO.getAllItemsList().then((value) => null);


   //await _allItems.removeWhere((element) => _itemsInPriceList.contains(element));

   // _itemsNotInPriceList = _allItems;





  }



  Future<void> getItemsInPriceList(String id_price_list) async {

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    ItemsCloudDAO.getItemsInPriceList(id_price_list).then((items) {

      isSearching = false;
      //_itemsInPriceList = _fullItemsList =   items;
      _itemsList = _fullItemsList =   items;

      notifyListeners();


    });

  }
  void SearchByName(String keywordTyped){

    isSearching = true;
    //_itemsList =[];
    if(keywordTyped.isEmpty){
      isSearching = false;
      _itemsList = _fullItemsList;
      notifyListeners();
    }else{
      isSearching = false;
      _itemsList = _fullItemsList.where((element) => element.description.toLowerCase().contains(keywordTyped.toLowerCase())).toList();
      notifyListeners();
    }
  }

  void SearchByBarcode(String keywordTyped){
    isSearching = true;
    //_itemsList =[];
    if(keywordTyped.isEmpty){
      isSearching = false;
      _itemsList = _fullItemsList;
      notifyListeners();
    }else{
      isSearching = false;
      _itemsList = _fullItemsList.where((element) => element.barcode.toLowerCase().contains(keywordTyped.toLowerCase())).toList();
      notifyListeners();
    }
  }

  void SearchByItemCode(String keywordTyped){
    isSearching = true;
    //_itemsList =[];
    if(keywordTyped.isEmpty){
      isSearching = false;
      _itemsList = _fullItemsList;
      notifyListeners();
    }else{
      isSearching = false;
      _itemsList = _fullItemsList.where((element) => element.itemCode.toLowerCase().contains(keywordTyped.toLowerCase())).toList();
      notifyListeners();
    }
  }



  void getVanSalesStock(String id_user) {
    isSearching = true;
    _itemsList =[];
    notifyListeners();

    ItemsDAO.getVanSalesStock(id_user).then((items) {

      isSearching = false;

      _itemsList = _fullItemsList =   items;

      notifyListeners();

    });
  }
}