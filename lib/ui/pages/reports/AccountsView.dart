import 'package:flutter/material.dart';


import '../../../core/dao/supplier_dao.dart';
import '../../../core/enums/ReportType.dart';
import '../../../core/model/supplier.dart';
import 'AccountsListItem.dart';

import 'ExpiryReportPage.dart';

class AccountsView extends StatefulWidget {
  final ReportType reportType;

  const AccountsView({Key key,@required this.reportType}) : super(key: key);
  @override
  _AccountsViewState createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {

  List<Supplier> _supplierList = [];

  @override
  void initState() {
    super.initState();

    _getSupplierList();
  }

  TextEditingController _searchClientController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          showCursor: true,
          autofocus: false,
          controller: _searchClientController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),

          decoration: InputDecoration(
            hintText: 'Search Supplier name',
            hintStyle: TextStyle(color: Colors.white60),
            suffixIcon: IconButton(
              icon: Icon(_supplierList.isEmpty &&
                  _searchClientController.text.length == 0
                  ? Icons.search
                  : Icons.cancel, color: Colors.white,),
              tooltip: 'Cancel',
              onPressed: () {
                setState(() {
                  _searchClientController.clear();
                  _supplierList.clear();
                });
              },
            ),
          ),
          onEditingComplete: () {
            setState(() {
              _supplierList.clear();
            });
          },
          onChanged: (value) {
            setState(() {
              //TODO
              /*_clientFilteredList = model.suppliers
                    .where((client) => client.supplier_name
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                    .toList();*/
            });
          },
        ),
        leading: BackButton(color: Colors.white,),
        backgroundColor: Color(0xFF262AAA),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              //TODO
                child: ListView.builder(
                    itemCount: _supplierList.isNotEmpty
                        ? _supplierList.length
                        : _supplierList.isEmpty &&
                        _searchClientController.text.length > 0
                        ? 0
                        : _supplierList.length,
                    itemBuilder: (context, index) {
                      Supplier supplier = _supplierList.isNotEmpty
                          ? _supplierList[index]
                          : _supplierList.isEmpty &&
                          _searchClientController.text.length > 0
                          ? _supplierList[index]
                          : _supplierList[index];
                      return AccountsListItem(
                        supplier: supplier,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              __) =>
                              ExpiryReportPage(client: _supplierList[index],
                                reportType: widget.reportType,)));
                        },
                      );
                    }
                )
            ),
          ],
        ),
      ),
    );
  }

  void _getSupplierList() {
    SupplierDAO().getSuppliers().then((value) {
      if (value.length > 0) {
        setState(() {
          _supplierList = value;
        });
      }
    }
    );
  }
}




