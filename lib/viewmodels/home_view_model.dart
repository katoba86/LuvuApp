
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/dialog_service.dart';

import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  List<Gift> _gifts;
  List<Gift> get gifts => _gifts;



  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateGiftViewRoute);
  }


  void logout() {
       _authenticationService.logOut();

  }
}