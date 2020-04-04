import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:luvutest/viewmodels/signup_view_model.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();


  void navigateToSignUp(){
    _navigationService.navigateTo(SignUpViewRoute);
  }


  Future signUpWithGoogle() async {
      SignUpViewModel suvm = new SignUpViewModel();
      return suvm.signUpWithGoogle();
  }
  Future signUpAnonymous() async {
      SignUpViewModel suvm = new SignUpViewModel();
      return suvm.signUpAnonymous();
  }


  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }



}
