import 'package:flutter/material.dart';


import '../../core/enums/ReportType.dart';
import 'reports/AccountsView.dart';
import 'reports/LocalRegionsPage.dart';
import 'reports/all_store_branchs_page.dart';


class ReportsPage extends StatefulWidget {

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountsView(reportType: ReportType.LineItemsReport,)));
              },
              child: Text('StockTake By Supplier',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all( Color(0xFF262AAA)),
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
              ),
            ),
            SizedBox(height: 14,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalRegionsPage(reportType:ReportType.LocationReport)));
              },
              child: Text('Stores By Region',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all( Colors.blue),
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
              ),

            ),
            SizedBox(height: 14,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllStoreBranchsPage(reportType:ReportType.LocationReport)));
              },
              child: Text('All Stores',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all( Colors.blue),
                minimumSize: MaterialStateProperty.all(Size(double.infinity,50)),
              ),

            ),

          ]
      ),
    );
  }
}
