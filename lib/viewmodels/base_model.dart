import 'package:flutter/widgets.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/user.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/navigation_service.dart';

class BaseModel extends ChangeNotifier {

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  User get currentUser => _authenticationService.currentUser;


  double position1 = 500;


  void initAnimations(){
    
    Future.delayed(Duration(seconds: 1),(){
      position1=0;
      this.notifyListeners();
    });
  }

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }


  bool _busy2 = false;
  bool get busy2 => _busy2;

  void setBusy2(bool value) {
    _busy2 = value;
    notifyListeners();
  }

  void goTo(String route){
      _navigationService.navigateTo(route);
  }
}
