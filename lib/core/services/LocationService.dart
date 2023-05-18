
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';




class LocationService {
  ///Checks if location is enabled & Returns current location as a [Position]
  static Future<Position> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;


    ///Display turn on location dialog prompt if location services are disabled
    ///Returns true if open location settings button is pressed
    Future<bool> turnOnLocationDialog(BuildContext context)async{
      bool turnOnLocation = false;
      turnOnLocation = await showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('Turn on location'),
        content: Text('This app needs location access to work correctly. Please turn on location'),
        actions: [
          TextButton(
            onPressed: (){

              Navigator.pop(context,true);
              return true;
            },
            child: Text('Open location settings'),
          ),
          // TextButton(
          //   onPressed: (){
          //     print('Cancel pressed.');
          //     Navigator.pop(context,true);
          //     return false;
          //   },
          //   child: Text('Cancel'),
          // ),
        ],
      ));
      return turnOnLocation;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
        bool turnOnLocation = false;
        // await showDialog(context: context, builder: (context)=>AlertDialog(
        //   title: Text('Turn on location'),
        //   content: Text('This app needs location access to work correctly. Please turn on location'),
        //   actions: [
        //     TextButton(
        //       onPressed: (){
        //         turnOnLocation = true;
        //         print('On confirmed pressed. Turn on location: $turnOnLocation');
        //         Navigator.pop(context,true);
        //       },
        //       child: Text('Open location settings'),
        //     )
        //   ],
        // )
        // );

        turnOnLocation = await turnOnLocationDialog(context);
      await Future.delayed(Duration(seconds: 1)); //delay before opening settings page

      if (turnOnLocation) {
        // if (Platform.isAndroid) {
        //   print('Location services are disabled.');
        //   AndroidIntent intent = AndroidIntent(
        //     action: 'android.settings.LOCATION_SOURCE_SETTINGS',
        //     // data: 'com.oribicom.logistixpro_stocktake_app',
        //   );
        //   await intent.launch();
        // }
        await Geolocator.openLocationSettings();
      }
      return Future.error('Returned. Location services are disabled.');
    }else{

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print('LOCATION PERMISSIONS ARE DENIED FOREVER');
      Fluttertoast.showToast(msg: 'Location permissions are denied. Please give this app permission from settings.');
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Fluttertoast.showToast(msg: 'Location permissions are denied. Please give this app permission from settings.');
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    print('Geolocator getting current location....');
    Fluttertoast.showToast(msg: 'Getting current location...');
    Position _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // currentLocation = _currentPosition;
    print('Current geolocation lat:${_currentPosition.latitude} lng:${_currentPosition.longitude}' );
    return _currentPosition;
  }

  ///Returns distance between two locations in meters
  static double calculateStoreBranchDistance(double startLat, double startLng,double endLat,double endLng){
    print('Calculating store branch difference...');
    print('Start Location ($startLat,$startLng) ($endLat,$endLng)');
    double storeBranchDistanceDifference = Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    return storeBranchDistanceDifference;
  }
}