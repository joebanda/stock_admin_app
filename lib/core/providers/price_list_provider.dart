

import 'package:flutter/material.dart';

import '../dao/PriceListDAO.dart';
import '../model/price_list.dart';




class PriceListProvider with ChangeNotifier{

  List<PriceList> _itemsList =[];
  List<PriceList> _fullItemsList =[];

  bool isSearching = false;

  List<PriceList> _priceListsByItemList =[];
  List get priceListsByItemList => _priceListsByItemList;

  List get itemsList => _itemsList;
  List get fullItemsList => _fullItemsList;

  bool get isSearchingStatus => isSearching;

  void getPriceLists(){

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    PriceListDAO.getPriceLists().then((items) {

      isSearching = false;

      _itemsList = _fullItemsList =   items;

     notifyListeners();

    });

  }

  void createNewPriceList(PriceList priceList){

    isSearching = true;
    _itemsList =[];
    notifyListeners();

    PriceListDAO.createPriceList(priceList).then((items) {

      isSearching = false;

      //_itemsList =  items;

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

  getPriceListsByItem(String id_item) {

    isSearching = true;
    _priceListsByItemList =[];
    notifyListeners();

    PriceListDAO.getPriceListsByItem( id_item).then((items) {

      isSearching = false;

      _priceListsByItemList =   items;

      notifyListeners();

    });

  }



}