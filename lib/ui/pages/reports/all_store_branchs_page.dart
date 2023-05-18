import 'package:flutter/material.dart';



import '../../../core/dao/store_branch_dao.dart';
import '../../../core/enums/ReportType.dart';

import '../../../core/model/StoreBranch.dart';

import '../../../theme.dart';
import 'ExpiryReportPage.dart';

class AllStoreBranchsPage extends StatefulWidget {
  final ReportType reportType;

  const AllStoreBranchsPage({Key key, @required this.reportType}) : super(key: key);

  @override
  _AllStoreBranchsPageState createState() => _AllStoreBranchsPageState();
}

class _AllStoreBranchsPageState extends State<AllStoreBranchsPage> {
  TextEditingController _searchStoreBranchController = TextEditingController();

  List<StoreBranch>  _storeBranchList = [];
  List<StoreBranch>  _fullStoreBranchList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getAllStoresList();
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
                    _storeBranchList = _fullStoreBranchList;
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
                _storeBranchList = _fullStoreBranchList
                    .where((storeBranch) => storeBranch.storeBranchName
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                    .toList();
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
                  _searchStoreBranchController.clear();
                 // _nameFilteredList.clear();
               _getAllStoresList();
                },
                icon: Icon(Icons.refresh,color: Colors.white,)
            )
          ],
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator(color: drawerBackgroungColor,)): Container(
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

  void _getAllStoresList() {

    _isLoading = true;
    StoreBranchDAO.getStoreBranches().then((value) {
      if (value.length > 0) {
        setState(() {
          _storeBranchList = _fullStoreBranchList = value;
        });
        _isLoading = false;
      }else{
        _isLoading = false;
      }
    }
    );
  }
}


