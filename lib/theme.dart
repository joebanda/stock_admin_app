
import 'package:flutter/material.dart';

TextStyle listTileDefaultTextStyle = TextStyle(color: Colors.white70,fontSize: 14.0, fontWeight: FontWeight.normal);
TextStyle listTileSelectedTextStyle = TextStyle(color: Colors.white,fontSize: 14.0, fontWeight: FontWeight.normal);

Color selectedColor = Color(0xFF4AC8EA);
Color iconColor = Color(0xFFFFFFFF);
Color menuTextColor = Color(0xFFFFFFFF);
Color drawerBackgroungColor = Color(0xFF262AAA);
 const primaryColor = Color(0xFF151026);
//Color drawerBackgroungColor = Color(0xFF424242);
//Color drawerBackgroungColor = Color(0xff52beff);


 InputDecoration textfieldInputDecoration(String hintText){


   InputDecoration _decoration_textfield = InputDecoration(
     hintText: hintText,
     filled: true,
     fillColor: Colors.grey[200],
     labelStyle: TextStyle(fontSize: 12),
     contentPadding: EdgeInsets.only(left: 30),
     enabledBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.blueGrey[50]),
       borderRadius: BorderRadius.circular(15),
     ),
     focusedBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.blueGrey[50]),
       borderRadius: BorderRadius.circular(15),
     ),

   ) ;

  return _decoration_textfield;
}


