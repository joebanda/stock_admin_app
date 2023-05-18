import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import 'core/model/master_user_model.dart';
import 'core/providers/itemsProvider.dart';
import 'core/providers/master_users_provider.dart';
import 'core/providers/price_list_provider.dart';
import 'core/router/delegate.dart';
import 'theme.dart';







void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routerDelegate = Get.put(MyRouterDelegate());
  MyApp() {
    routerDelegate.pushPage(name: '/');
  }


  static String db_name ="" ;
  static String license_type="" ;
  static MasterUserModel authenticatedUser;
  static String job_role="" ;
  static String id_autheticated_user="" ;

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  MasterUserProvider()),
        ChangeNotifierProvider(create: (_) =>  ItemsProvider()),
        ChangeNotifierProvider(create: (_) => PriceListProvider()),


      ],
      child: MaterialApp(
        title: 'LogistixPro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.yellow,
            onPrimary: Colors.black,
            secondary: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Router(
          routerDelegate: routerDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
       ),
    );
  }
}

