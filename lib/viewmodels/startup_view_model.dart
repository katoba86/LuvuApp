import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/navigation_service.dart';

import 'base_model.dart';

class StartUpViewModel extends BaseModel{

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();



  Future handleStartupLogic() async{
      var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

      _navigationService.replaceTo(
        (hasLoggedInUser)?HomeViewRoute:LoginViewRoute
      );
  
  }

}