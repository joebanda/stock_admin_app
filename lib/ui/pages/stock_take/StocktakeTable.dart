import 'package:flutter/material.dart';



import '../../../core/dao/stocktake_task_dao.dart';
import '../../../core/model/stocktake_task.dart';
import '../../../core/services/Api.dart';
import '../../../main.dart';
import 'stock_count_lines_table.dart';




class StocktakeTable extends StatefulWidget {
  StocktakeTable() : super();
  final String title = 'Stock Take List';

  @override
  StocktakeTableState createState() =>StocktakeTableState();


}

class StocktakeTableState extends State<StocktakeTable> {
  List<StocktakeTask> _stocktake_taskList;
  StocktakeTask _selectedStore;
  String _titleProgress;

  TextEditingController _searchRetailRegionController;

  List<StocktakeTask> _nameFilteredList = [];
  bool _showSearchBar = false;


  @override
  void initState() {
    super.initState();
    _stocktake_taskList = [];
    _titleProgress = widget.title;
    _searchRetailRegionController = TextEditingController();

    _getStocktakeTasksByStatusId('Open',MyApp.id_autheticated_user);

  }

  //Method to update progress in AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }



  _getStocktakeTasks( String status) {
    _showProgress('Loading ........');
    StocktakeTaskDAO.getObjects(status).then((e) {
      setState(() {
        _stocktake_taskList = e;
      });
      _showProgress(widget.title);
      print('Length ${e.length}. e:$e');
    });
  }

  _getStocktakeTasksByStatusId( String status, String id_staff) {

    print('status '+ status +' is'+ id_staff);
    _showProgress('Loading ........');
    Api.getStockTakeTasksByStatusAndId(status:status,id_staff:id_staff ).then((e) {
      print(e.length);
      setState(() {
        _stocktake_taskList = e;
      });
      _showProgress(widget.title);

    });
  }

  _updateStatus( String status, String stocktakeTaskid) {
    _showProgress('updating ........');
    StocktakeTaskDAO.updateStatus(status, stocktakeTaskid).then((e) {

      if('success'== e){
        setState(() {
          _stocktake_taskList.removeWhere((element) => element.id == stocktakeTaskid);
        });
        _showProgress(widget.title);


      }

    });
  }



  ///Create a DataTable snd show the employees
  SingleChildScrollView _dataBody() {
    //Scroll both Vertical and Horizontal
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: FittedBox(
          child: DataTable(
            columns: [
              DataColumn(
                label: Text('Chain Store'),
              ),
              DataColumn(
                label: Text('Branch.'),
              ),
              DataColumn(
                label: Text('Ref'),
              ),
           /*   DataColumn(
                label: Text('Details'),
              ),*/
            ],
            rows: _stocktake_taskList.map((stocktake_task) => DataRow(
                cells: [
                  DataCell(Text(stocktake_task.chain_store_name.toString()),
                      onTap: (){

                        stocktake_task.id = stocktake_task.id;

                        Navigator.push(context, new MaterialPageRoute(builder: (context)=> StockCountLineTable(stocktake_task)));

                        _selectedStore = stocktake_task;



                      }
                  ),
                  DataCell(Text(stocktake_task.store_branch_name.toString()),
                    onTap: (){

                      stocktake_task.id = stocktake_task.id;

                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> StockCountLineTable(stocktake_task)));

                      _selectedStore = stocktake_task;


                    },
                  ),
                  DataCell(Text(stocktake_task.reference.toString()),
                    onTap: (){

                      stocktake_task.id = stocktake_task.id;

                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> StockCountLineTable(stocktake_task)));

                      _selectedStore = stocktake_task;


                    },
                  ),
              /*    DataCell(IconButton(icon: Icon(Icons.done),
                    onPressed: (){
                     // _deleteEmployee(employee);
                    },
                  ),

                  ),*/
                ]),

            ).toList() ,
          ),
        ),

      ),
    );
  }

  ///Create listview data table
  ListView _listViewDataBody({@required List<StocktakeTask> tasks}) {
    //Scroll both Vertical and Horizontal
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context,index){
          StocktakeTask task = tasks[index];
          return TextButton(
            onPressed: () {
              task.id = task.id;
              Navigator.push(context, new MaterialPageRoute(builder: (context)=> StockCountLineTable(task)));
              _selectedStore = task;
            },
            child: Container(

              decoration: BoxDecoration(
               

                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                tileColor: Colors.grey[200],
                title: Text(task.store_branch_name),
                subtitle: Text('${task.chain_store_name}\n${task.reference}'),
                isThreeLine: true,
              ),
            ),
          );
        }
    );
  }


  //inputDialog
  Future<StocktakeTask> closeStocktakeDialog(BuildContext context){
    TextEditingController _storeNameController = TextEditingController();
    TextEditingController _locationController = TextEditingController();
    StocktakeTask stocktake_task = StocktakeTask();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Complete Stock count'),
        content: Column(
            children: <Widget>[

              Text('Click on finished below if you have completed the Stock Count\n\n'
                  '!!This will close the count on this stocktake task')

            ]
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Finished'),
            onPressed: (){

             // _updateStatus('Closed',_selectedStore.stocktake_id,);

              StocktakeTaskDAO.updateStatus('Closed',_selectedStore.id).then((e) {

                if('success'== e){
                  Navigator.of(context).pop();

                  setState(() {
                    _stocktake_taskList.removeWhere((element) => element.id == _selectedStore.id);
                  });

                  _showProgress(widget.title);

                }

              });


            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text('Cancel'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  //UI
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: _showSearchBar ? TextField(
          showCursor: true,
          autofocus: true,
          controller: _searchRetailRegionController,
          // cursorColor: Colors.white,
          // style: TextStyle(color: Colors.white),

          decoration: InputDecoration(
            hintText: 'Search name',
            // hintStyle: TextStyle(color: Colors.white60),
            suffixIcon: IconButton(
              icon: Icon(_nameFilteredList.isEmpty && _searchRetailRegionController.text.length==0 ? Icons.search : Icons.cancel,color: Colors.white,),
              tooltip: 'Cancel',
              onPressed: (){
                setState(() {
                  _searchRetailRegionController.clear();
                  _nameFilteredList.clear();
                });
              },
            ),
          ),
          onEditingComplete: (){
            setState(() {
              _nameFilteredList.clear();
            });
          },
          onChanged: (value) {
            setState(() {
              _nameFilteredList = _stocktake_taskList
                  .where((task) => task.chain_store_name
                  .toLowerCase()
                  .contains(value.toLowerCase())
                ||  task.store_branch_name
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                  .toList();
            });
          },
        ) : Text(_titleProgress), //show progress
        actions: <Widget>[
          IconButton(
            onPressed: (){
              setState(() {
                if(_showSearchBar){
                    _searchRetailRegionController.clear();
                    _nameFilteredList.clear();
                  }
                  _showSearchBar = !_showSearchBar;
              });

            },
            icon: _showSearchBar? Icon(Icons.cancel):Icon(Icons.search),
            tooltip: 'Search',
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              //create input dialog

              // _getStocktakeTasks('Open');
              _getStocktakeTasksByStatusId('Open',MyApp.id_autheticated_user);
            },
          ),

        ],
      ),
      body: Container(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(),
          Expanded(
            // child: _dataBody(),
            child: _listViewDataBody(tasks: _nameFilteredList.isNotEmpty
                ? _nameFilteredList
                : _nameFilteredList.isEmpty && _searchRetailRegionController.text.length > 0
                ? _stocktake_taskList
                :_stocktake_taskList),
          )
        ],
      ),
      ),
  /*    floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addStocktakeTask();
        },
        child: Icon(Icons.add),
      ),*/
    );
  }

}

