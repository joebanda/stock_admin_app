import 'package:flutter/material.dart';


import '../../../core/dao/store_branch_dao.dart';
import '../../../core/enums/ReportType.dart';
import '../../../core/model/RetailRegion.dart';
import '../../../core/model/StoreBranch.dart';

import 'ExpiryReportPage.dart';

class StoreBranchPage extends StatefulWidget {
  final ReportType reportType;
  final RetailRegion retailRegion;
  const StoreBranchPage({Key key, @required this.reportType, @required this.retailRegion}) : super(key: key);

  @override
  _StoreBranchPageState createState() => _StoreBranchPageState();
}

class _StoreBranchPageState extends State<StoreBranchPage> {
  TextEditingController _searchStoreBranchController = TextEditingController();

  List<StoreBranch>  _storeBranchList = [];

  @override
  void initState() {
    super.initState();

    _getStoresByRegionList(widget.retailRegion.id);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: TextField(
            showCursor: true,
            autofocus: false,
            controller: _searchStoreBranchController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),

            decoration: InputDecoration(
              hintText: 'Search branch name',
              hintStyle: TextStyle(color: Colors.white60),
              suffixIcon: IconButton(
                icon: Icon(_storeBranchList.isEmpty && _searchStoreBranchController.text.length==0 ? Icons.search : Icons.cancel,color: Colors.white,),
                tooltip: 'Cancel',
                onPressed: (){
                  setState(() {
                    _searchStoreBranchController.clear();
                    _storeBranchList.clear();
                  });
                },
              ),
            ),
            onEditingComplete: (){
              setState(() {
                _storeBranchList.clear();
              });
            },
            onChanged: (value) {

              //TODO
              setState(() {
             /*   _nameFilteredList = model.storeBranches
                    .where((storeBranch) => storeBranch.storeBranchName
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                    .toList();*/
              });
            },
          ),
          leading: BackButton(color: Colors.white,),
          backgroundColor: Color(0xFF262AAA),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: ()async{

                  //TODO
              /*    _searchStoreBranchController.clear();
                  _nameFilteredList.clear();
                  if (widget.reportType==ReportType.LineItemsReport) {
                    await model.fetchStoreBranches();
                  }else{
                    await model.fetchStoreBranchesByRegionId(widget.retailRegion.id);
                  }*/
                },
                icon: Icon(Icons.refresh,color: Colors.white,)
            )
          ],
        ),
        body:  Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(

                //TODO
                  child: ListView.builder(
                      itemCount:  _storeBranchList.isNotEmpty
                          ? _storeBranchList.length
                          : _storeBranchList.isEmpty && _searchStoreBranchController.text.length > 0
                          ? 0
                          : _storeBranchList.length,
                      itemBuilder: (context, index) {
                        StoreBranch storeBranch = _storeBranchList.isNotEmpty
                            ? _storeBranchList[index]
                            : _storeBranchList.isEmpty && _searchStoreBranchController.text.length > 0
                            ? _storeBranchList[index]
                            : _storeBranchList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          child: ElevatedButton(
                            onPressed: () {
                             // var branch = model.getSelectedStoreBranch(storeBranch: storeBranch);
                              Navigator.push(context, MaterialPageRoute(builder: (__) => ExpiryReportPage(
                                storeBranch: _storeBranchList[index],
                                reportType: widget.reportType,
                              ))
                              );
                            },
                            child: Text('${storeBranch.storeBranchName}',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(
                              backgroundColor:  MaterialStateProperty.all( Colors.blue),
                              minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
                            ),
                          ),
                        );
                      }
                  )
              ),
            ],
          ),
        ),
      );

  }

  void _getStoresByRegionList(String id_retail_region) {

    StoreBranchDAO.getStoreBranchesByRegionId(id_retail_region).then((value) {
      if (value.length > 0) {
        setState(() {
          _storeBranchList = value;
        });
      }
    }
    );
  }
}


