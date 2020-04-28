import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop({result}) {
    return _navigationKey.currentState.pop(result);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {



    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route)=> false);
  }
  
}
