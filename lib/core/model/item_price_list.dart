class ItemPriceList {
  String id;
  String itemId;
  String priceListId;
  String currencyId;
  String currencySymbol;
  double price;

  ItemPriceList({
    this.id,
    this.itemId,
    this.priceListId,
    this.currencyId,
    this.currencySymbol,
    this.price,
  });

  factory ItemPriceList.fromJson(Map<String, dynamic> json) {
    return ItemPriceList(
      id: json['id'],
      itemId: json['id_item'],
      priceListId: json['id_price_list'],
      currencyId: json['id_currency'],
      currencySymbol: json['currency_symbol'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_item': itemId,
      'id_price_list': priceListId,
      'id_currency': currencyId,
      'currency_symbol': currencySymbol,
      'price': price,
    };
  }
}
