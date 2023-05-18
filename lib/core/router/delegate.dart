


import 'package:flutter/material.dart';

import '../../ui/pages/app_ui/HomeNavigation.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/pages/stock_take/StocktakeTable.dart';




class MyRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier,
        PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final _pages = <Page>[];

  @override
  // TODO: implement navigatorKey
  final navigatorKey = GlobalKey<NavigatorState>();
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }



  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

  bool _onPopPage(Route route, result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;

  }

  @override
  Future<bool> popRoute() {

    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmAppExit();
  }

  @override
  Future<bool> logOut() {

    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmAppExit();
  }

  Future<bool> _confirmAppExit() {
    return showDialog<bool>(
        context: navigatorKey.currentContext,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
                actions: [
                TextButton(
                child: const Text('Cancel',style: TextStyle(color: Colors.black54),),
            onPressed: () => Navigator.pop(context, true),
          ),
          TextButton(
          child: const Text('Confirm',style: TextStyle(color: Colors.black54),),
          onPressed: () => Navigator.pop(context, false),
          ),
          ],
          );
        });
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget child;
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        child = LoginPage();
        break;
      case '/dashboard':
       // child = SecondPage(routeSettings.arguments);
        child = HomeNavigation(masterUserModel: args,);
        break;
      case 'SalesHeaderTable':
        child = StocktakeTable();
        break;
    }
    return MaterialPage(
      child: child,
      key: Key(routeSettings.name),
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  void pushPage({@required String name, dynamic arguments}) {
    _pages.add(_createPage(
        RouteSettings(name: name, arguments: arguments)
    ));
    notifyListeners();
  }
}