import 'package:flutter/material.dart';


class Dialogs{
  information(BuildContext context, String title, String description,
      {Widget icon}){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){

          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                      width: 500,
                      child: Row(
                        children: [
                          icon??Container(),
                          icon!=null?SizedBox(width: 10,) : Container(),
                          Text(description),
                        ],
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              )
            ],
          );
        }
    );
  }

  waiting(BuildContext context, String title, String description){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){

          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),

          );
        }
    );
  }

  confirm(BuildContext context, String title, String description){
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){

          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => _confirmResults(true,context),
                child: Text('YES'),
              ),
              ElevatedButton(
                onPressed: () => _confirmResults(false,context),
                child: Text('CANCEL'),
              )
            ],
          );
        }
    );
  }

  _confirmResults(bool isYes, BuildContext context){
    if(isYes){
      print('Yes Action');
      Navigator.pop(context, true);
    }else{
      print('Cancel Action');
      Navigator.pop(context, false);
    }
  }



}