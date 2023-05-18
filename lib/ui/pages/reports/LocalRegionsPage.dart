import 'package:flutter/material.dart';


import '../../../core/dao/region_dao.dart';
import '../../../core/enums/ReportType.dart';
import '../../../core/model/RetailRegion.dart';
import 'StoreBranchPage.dart';


class LocalRegionsPage extends StatefulWidget {
  const LocalRegionsPage({Key key, @required this.reportType}) : super(key: key);
  final ReportType reportType;
  @override
  _LocalRegionsPageState createState() => _LocalRegionsPageState();
}

class _LocalRegionsPageState extends State<LocalRegionsPage> {
  TextEditingController _searchRetailRegionController = TextEditingController();

  List<RetailRegion> _regionsList = [];

  @override
  void initState() {
    super.initState();

    _getRegionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            showCursor: true,
            autofocus: false,
            controller: _searchRetailRegionController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),

            decoration: InputDecoration(
              hintText: 'Search Region',
              hintStyle: TextStyle(color: Colors.white60),
              suffixIcon: IconButton(
                icon: Icon(_regionsList.isEmpty && _searchRetailRegionController.text.length==0 ? Icons.search : Icons.cancel,color: Colors.white,),
                tooltip: 'Cancel',
                onPressed: (){
                  setState(() {
                    _searchRetailRegionController.clear();
                    _regionsList.clear();
                  });
                },
              ),
            ),
            onEditingComplete: (){
              setState(() {
                _regionsList.clear();
              });
            },
            onChanged: (value) {
              setState(() {
                //TODO
                // _nameFilteredList = model.retailRegions
                //     .where((retailRegion) => retailRegion.regionName
                //     .toLowerCase()
                //     .contains(value.toLowerCase()))
                //     .toList();
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
                 /* _searchRetailRegionController.clear();
                  _nameFilteredList.clear();
                  await model.fetchRetailRegions();*/
                },
                icon: Icon(Icons.refresh,color: Colors.white,)
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(

                //TODO
                  child: ListView.builder(
                      itemCount:  _regionsList.isNotEmpty
                          ? _regionsList.length
                          : _regionsList.isEmpty && _searchRetailRegionController.text.length > 0
                          ? 0
                          : _regionsList.length,
                      itemBuilder: (context, index) {
                        RetailRegion retailRegion = _regionsList.isNotEmpty
                            ? _regionsList[index]
                            : _regionsList.isEmpty && _searchRetailRegionController.text.length > 0
                            ? _regionsList[index]
                            : _regionsList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          child: ElevatedButton(
                            onPressed: () {
                             // RetailRegion region = model.getSelectedRetailRegion(retailRegion: retailRegion);
                              Navigator.push(context, MaterialPageRoute(builder: (__) => StoreBranchPage(
                                  reportType: widget.reportType,
                                  retailRegion: _regionsList[index],
                              )));
                            },
                            child: Text('${retailRegion.regionName}',style: TextStyle(color: Colors.white),),
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

  void _getRegionsList() {

    RegionsDAO.getRegions().then((value) {
      if (value.length > 0) {
        setState(() {
          _regionsList = value;
        });
      }
    }
    );
  }

}


