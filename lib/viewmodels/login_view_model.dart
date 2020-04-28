import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();


  Future signUpWithFacebook() async{
    setBusy(true);

    var result = await _authenticationService.loginWithFacebook();


    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: "Klappt nicht...",
      );
    }
  }

  Future signUpWithGoogle() async {
    setBusy(true);

    var result = await _authenticationService.loginWithGoogle();

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
