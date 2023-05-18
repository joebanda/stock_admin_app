import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black12,
                offset: Offset(0.0,15.0),
                blurRadius: 15.0
            ),
            BoxShadow(color: Colors.black12,
                offset: Offset(0.0,-10.0),
                blurRadius: 10.0
            ),
          ]
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0,right: 16.0 , top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login", style: TextStyle(
                fontSize: 10,
                letterSpacing: 2.0
            )),
            SizedBox(
              height: 30.0,
            ),
            Text("Username", style: TextStyle(
                fontSize: 10,
                letterSpacing: 2.0
            )),
            TextField(
              decoration: InputDecoration(
                  hintText: "username",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0
                  )
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("Password", style: TextStyle(
                fontSize: 10,
                letterSpacing: 2.0
            )),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0
                  )
              ),
            ),
            SizedBox(
                height: 35
            ),

          ],
        ),
      ),
    );
  }
}

