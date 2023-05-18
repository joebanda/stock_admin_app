
import 'dart:convert';
List<PriceList> FromJson(String str) => List<PriceList>.from(json.decode(str).map((x) => PriceList.fromJson(x)));

String ToJson(List<PriceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PriceList {
  String id;
  String idCurrency;
  String currencySymbol;
  String priceListName;
  String description;
  bool isPromoPrice ;
  String isActive;
  String isDefault;
  String isTaxable;
  String isPriceIncludeTax;
  String startDate;
  String endDate;
  String deleted;
  String createdBy;
  String status;

  String itemCode;
  String id_item;
  String id_price_list;
  String id_item_price_list;
  String barcode;
  String uom;
  String unitPrice;
  String category;




  PriceList(
      {
        this.id,
        this.idCurrency,
        this.currencySymbol,
        this.description,
        this.priceListName,
        this.isPromoPrice,
        this.isActive,
        this.isDefault,
        this.isTaxable,
        this.isPriceIncludeTax,
        this.startDate,
        this.endDate,
        this.itemCode,
        this.id_item,
        this.id_price_list,
        this.id_item_price_list,
        this.barcode,
        this.uom,
        this.unitPrice,
        this.category,
        this.deleted,


      });

  PriceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCurrency = json['id_currency'];
    currencySymbol = json['currency_symbol'] == null ? "" : json['currency_symbol'];
   priceListName = json['priceListName'];
    description = json['description'];
    isActive  = json['isActive'];
    isDefault  = json['isDefault'];
    isTaxable  = json['isTaxable'];
    isPriceIncludeTax  = json['isPriceIncludeTax'];
    startDate  = json['startDate'];
    endDate  = json['endDate'];
    deleted  = json['deleted'];
    createdBy  = json['createdBy'];
    status  = json['status'];
    itemCode  = json['itemCode'];
    id_item  = json['id_item'];
    id_price_list  = json['id_price_list'];
    id_item_price_list  = json['id_item_price_list'];
    barcode  = json['barcode'];
    uom  = json['uom'];
    unitPrice  = json['unitPrice'];
    category  = json['category'];
    isPromoPrice  = json['isPromoPrice'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_currency'] = this.idCurrency;
    data['currency_symbol'] = this.currencySymbol;
    data['priceListName'] = this.priceListName;
    data['description'] = this.description as String;
    data['isActive'] = this.isActive;
    data['isDefault'] = this.isDefault;
    data['isTaxable'] = this.isTaxable;
    data['isPriceIncludeTax'] = this.isPriceIncludeTax;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;

    data['deleted'] = this.deleted;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['itemCode'] = this.itemCode;
    data['id_item'] = this.id_item;
    data['id_price_list'] = this.id_price_list;
    data['id_item_price_list'] = this.id_item_price_list;
    data['barcode'] = this.barcode;
    data['uom'] = this.uom;
    data['unitPrice'] = this.unitPrice;
    data['category'] = this.category;
    data['isPromoPrice'] = this.isPromoPrice;



    return data;
  }
}


