import 'package:flutter/material.dart';

import '../../../core/model/supplier.dart';


class AccountsListItem extends StatelessWidget {
  final Supplier supplier;
  final Function onTap;
  const AccountsListItem({this.supplier, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: Offset(0,1),
                blurRadius: 0.5,
              )
            ]),

        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(supplier.supplier_name.toString())),
      ),
    );
  }
}
