import 'package:luvutest/locator.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/navigation_service.dart';

import 'base_model.dart';

class DetailViewModel extends BaseModel{

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();


  Gift _gift = new Gift(name: '',id: null);

  Gift getGift(){
    return this._gift;
  }

  void setGift(Gift gift){
    print(gift.name);
    this._gift = gift;
  }


  Future handleStartupLogic() async{

  }

}