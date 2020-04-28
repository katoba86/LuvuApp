

import 'package:luvutest/locator.dart';
import 'package:luvutest/services/dialog_service.dart';

import 'base_model.dart';

class SettingsViewModel extends BaseModel{


  final DialogService _dialogService = locator<DialogService>();

  bool _receiveNotifications = false;
  bool _receiveProducts = true;

  bool get receiveNotifications => _receiveNotifications;

  set receiveNotifications(bool value) {
    _receiveNotifications = value;
    this.notifyListeners();
  }

  bool get receiveProducts => _receiveProducts;

  set receiveProducts(bool value) {
    _receiveProducts = value;
    this.notifyListeners();
  }


  void deleteAccount(){
    _dialogService.showConfirmationDialog(confirmationTitle: "Ja",cancelTitle: "Nein",title: "Wirklisch löschen",description: "Dieser Vorgang kann nicht rückgängig gemacht werden");
  }


}