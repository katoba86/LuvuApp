

import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/Lists.dart';

import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:luvutest/services/dialog_service.dart';

import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/viewmodels/base_model.dart';

class SavedGiftsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _apiService = new ApiService();

  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  List<Gift> _gifts = new List<Gift>();
  List<Gift> get gifts => _gifts;

  Lists customList;

  void setCustomList(Lists list){
    this.customList = list;
  }

  void getInitialGifts() async {
    setBusy(true);


    if(this.customList==null) {
      this._gifts =
      await _apiService.getGifts(_authenticationService.currentUser);
    }else{
      this._gifts = await _apiService.getListGifts(this.customList,_authenticationService.currentUser);
    }

    print("Objects loaded");
    print(this._gifts.length);
    setBusy(false);
  }

  Future<Null> reloadGifts() async{
    this.getInitialGifts();
    return null;
  }

  Future deleteGift(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the gift?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
   //   int id = _gifts[index].id;

   //   Gift g = _gifts[index];

      //_gifts.removeWhere((Gift item)=>item.id == id);

      _apiService.deleteGift(_gifts[index],_authenticationService.currentUser).then((_){

        _gifts.removeAt(index);
        this.notifyListeners();


      });
      print("Exec finished");

    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateGiftViewRoute);
  }

  void editPost(int index) async {
    print("test");
    final result = await _navigationService.navigateTo(CreateGiftViewRoute,
        arguments: _gifts[index]);
    if(result=="reload"){
      this.reloadGifts();
    }
  }


  void viewGift(int index) async {

    await _navigationService.navigateTo(DetailViewRoute,
        arguments: _gifts[index]);
  }

  void logout() {
       _authenticationService.logOut();

  }
}