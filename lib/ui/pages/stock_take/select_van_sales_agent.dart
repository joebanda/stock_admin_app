import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../theme.dart';
import '../../../core/model/master_user_model.dart';
import '../../../core/providers/master_users_provider.dart';
import 'ViewVanSalesStock.dart';


class SelectVanSalesAgents extends StatefulWidget {
  const SelectVanSalesAgents({Key key}) : super(key: key);

  @override
  State<SelectVanSalesAgents> createState() => _SelectVanSalesAgentState();
}

class _SelectVanSalesAgentState extends State<SelectVanSalesAgents> {



  ScrollController _controllerOne;

  @override
  void initState() {

    super.initState();
    _controllerOne = ScrollController();
    //get all users with role van sales agent
    _getVanSalesAgents();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Van Sales Agent'),
        ),
        body: Container(
            child: Column(
              children: [
                Expanded(child: context.watch<MasterUserProvider>().isSearchingStatus
                        ? Center(child: CircularProgressIndicator(color: drawerBackgroungColor))
                        : Container(child: context.watch<MasterUserProvider>().usersList.length >= 0 ? _listViewDataBody(users_List: context.watch<MasterUserProvider>().usersList)
                            : Center(child: Container(width: 250, child: Text('Items not found'))))),
              ],
            )));
  }

  void _getVanSalesAgents() {

    //get all users with role van sales agent
    context.read<MasterUserProvider>().getUsersByRole('VAN SALES');


  }

  _listViewDataBody({@required List<MasterUserModel> users_List}) {
    //Scroll both Vertical and Horizontal
    ScrollPhysics physics = const BouncingScrollPhysics();
    return Scrollbar(
      controller: _controllerOne,
      isAlwaysShown: true,
      thickness: 15,
      child: ListView.builder(
        controller: _controllerOne,

        itemCount: users_List.length,
        physics: physics,
        //scrollDirection:  Axis.,
        shrinkWrap: true,
        itemBuilder: (context, index) => Card(
          elevation: 6,
          margin: EdgeInsets.all(10.0),
          child: ListTile(

            title: Text('${users_List[index].first_name} ${users_List[index].last_name}'),
            subtitle: Text(
                'Phone: ${users_List[index].mobile_phone}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

              ],
            ),
            onTap: () async {

              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewVanSalesStock(users_List[index],)));


            },
          ),
        ),
      ),
    );
  }

}
