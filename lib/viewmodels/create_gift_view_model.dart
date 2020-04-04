


import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_camera/page/camera.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:luvutest/constants/config.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/API/ApiService.dart';
import 'package:luvutest/services/cloud_storage_service.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/ui/widgets/iconpicker/iconpicker.dart';
import 'package:luvutest/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateGiftViewModel extends BaseModel {
  final ApiService _apiService = new ApiService();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =  locator<CloudStorageService>();


  Contact formContact;

  String formTitle;
  String formDescription;
  String formDate;

  File _selectedImage;
  File get selectedImage => _selectedImage;

  bool isCameraReady =false;
  bool showCapturedPhoto = false;
  var imagePath;

  Gift _edittingGift;
  Icon selectedIcon = Icon(Icons.card_giftcard);

  bool get _editting => _edittingGift != null;


  Gift getGift(){
    return this._edittingGift;
  }




  pickIcon(BuildContext context) async{
    IconData icon = await FlutterIconPicker.showIconPicker(context, icons: ALLOWED_ICONS,searchBar:false );

    _edittingGift.icon = FlutterIconPicker.iconToString(icon);

  }




  Future selectImage(BuildContext context) async {
    File file = await  Navigator.push(context, MaterialPageRoute(builder: (context) => Camera()));
    _selectedImage = file;
  }

  Future addGift({@required String title,String description, String date,Contact contact,String theme}) async {
    setBusy(true);

    var result;
    CloudStorageResult storageResult;

    if (!_editting && _selectedImage!=null) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }




    if (!_editting) {
      result = await _apiService
          .addGift(Gift(name: title,id: null,description: description,get_up_to:(date!=null && date!="")?date:null),currentUser);
    } else {
      result = await _apiService.updateGift(Gift(
        name: title, id: _edittingGift.id,description: description,get_up_to:(date!=null && date!="")?date:null
      ),currentUser);
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create gift',
        description: result,
      );
    }
    _navigationService.pop(result:"reload");
    //_navigationService.navigateTo(SavedGiftsViewRoute,arguments: true);
  }

  void setEdittingGift(Gift edittingGift) {
    _edittingGift = edittingGift;
    if(null != edittingGift){
      this.formDescription = _edittingGift.description;
      this.formDate = _edittingGift.get_up_to;
    }
  }
}