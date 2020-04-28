

import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/Lists.dart';

import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/dialog_service.dart';

import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/ui/views/detail_view.dart';
import 'package:luvutest/viewmodels/base_model.dart';

class ListsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _apiService = new ApiService();

  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  List<Lists> _lists = new List<Lists>();
  List<Lists> get lists => _lists;

  void getInitialLists() async {
    setBusy(true);




    this._lists = await _apiService.getLists(_authenticationService.currentUser);

    print("Objects loaded");
    setBusy(false);
  }

  Future<Null> reloadList() async{
    this.getInitialLists();
    return null;
  }



  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateGiftViewRoute);
  }


  void viewList(int index) async {

    Map<String,dynamic> arguments = new Map<String,dynamic>();
    arguments["list"] = _lists[index];

    await _navigationService.navigateTo(SavedGiftsViewRoute,
        arguments: arguments);
  }

  void logout() {
    _authenticationService.logOut();

  }
}