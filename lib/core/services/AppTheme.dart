import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



///Contains app theme. Fonts and Colors.
class AppTheme {
  AppTheme._();
  static final timerColor = Colors.blueGrey[700];
  static const String fontName = 'Roboto';
  static const Color darkestGrey = Color.fromRGBO(82, 87, 77, 1);
  static const Color darkGrey = Color.fromRGBO(84,79,89,1);
  static const Color darkGreyLight = Color.fromRGBO(103, 98, 110, 1);
  static const Color grey = Color.fromRGBO(122, 116, 130, 1);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color spacer = Color(0xFFF2F2F2);
  static final BorderRadius smallBoxBorderRadius = BorderRadius.circular(5);
  static final BorderRadius mediumBoxBorderRadius = BorderRadius.circular(10);
  static final BorderRadius largeBoxBorderRadius = BorderRadius.circular(15);
  static final BorderRadius actionBoxBorderRadius = BorderRadius.circular(30);
  static final Color mainColor = Colors.blueAccent;

 // static SpinKitChasingDots loading_spinner =  SpinKitChasingDots(  color: Colors.blueAccent,  size: 80.0,  );
  static SpinKitChasingDots loading_spinner =  SpinKitChasingDots(  color: Colors.blueAccent,  size: 80.0,  );
  static SpinKitWave wave_spinner =  SpinKitWave(  color: Colors.green,  size: 20.0,  );
  static SpinKitDoubleBounce doubleBounce_spinner =  SpinKitDoubleBounce(  color: Colors.red,  size: 18.0,  );

  static const BoxShadow mainBoxShadow = BoxShadow(
    color: deactivatedText,
    offset: Offset(0, 1),
    blurRadius: 5,
  );

  static final BoxDecoration actionButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.blueAccent,
  );

  static final BoxDecoration startButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.lightGreen,
  );

  static final BoxDecoration stopButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.red,
  );

  static final BoxDecoration addClockingButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Colors.lightBlue,
  );

  static const TextStyle headlineBold = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.blueGrey,
  );
  static const TextStyle headlineRegular = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  static const TextStyle specialNumbers = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 44,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 18/20,
  );
  static const TextStyle textLarge = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 36,
  );
  static const TextStyle textMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 24,
  );
  static const TextStyle textSmall = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  static const TextStyle addClockingPageTextStyle = TextStyle(fontSize: 14,fontWeight: FontWeight.normal);
  static const TextStyle addClockingPageTitleTextStyle = TextStyle(fontSize: 14,fontWeight: FontWeight.bold);

  static  ShapeBorder blueRoundedRectangleButton = RoundedRectangleBorder(side:BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(18.0)  );
  static  ShapeBorder redRoundedRectangleButton = RoundedRectangleBorder(side:BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(18.0)  );


  static const Decoration boxDecoration_white=  BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        )
      ]
  );

  static const Decoration boxDecoration_blue=  BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        )
      ]
  );

  static const TextTheme textTheme = TextTheme(
    headline1: headlineBold,
    headline2: headlineRegular,
    headline3: headlineSmall,
    bodyText1: textMedium,
    bodyText2: textSmall,
    caption: titleSmall,
    button: textSmall,
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}


