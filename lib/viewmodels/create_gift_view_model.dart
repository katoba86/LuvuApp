


import 'dart:convert';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/GiftContact.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/services/navigation_service.dart';

import 'package:luvutest/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateGiftViewModel extends BaseModel {
  final ApiService _apiService = new ApiService();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Map<String,String> editList = new Map<String,String>();

  Contact formContact;
  String formTitle;


  File _selectedImage;
  File get selectedImage => _selectedImage;

  Gift _edittingGift;
  bool get _editting => _edittingGift != null && _edittingGift.id!=null;



  Gift getGift(){
    return this._edittingGift;
  }


  void removeImage(){
    this._edittingGift.hasImage=false;
    editList["removeImage"] = "true";
    if(this.selectedImage!=null){
      this._selectedImage=null;
    }
    this.notifyListeners();
  }


  Future addGift({@required String title,String description, String date,Contact contact,String theme}) async {
    setBusy(true);

    var result;




    if (!_editting) {

      GiftContact c = new GiftContact();
      if(this.formContact!=null && this.formContact.displayName!="") {

        c.id = formContact.identifier;
        c.name = formContact.displayName;
        if (formContact is Contact && formContact.phones != null &&
            formContact.phones.length >= 1) {
          c.phones = formContact.phones.first.value;
        }
      }
      print(c.id);
      result = await _apiService.addGift(Gift(name: title,id: null,toContact: c),currentUser,file: _selectedImage);
    } else {


      if(_edittingGift.name!=title){
        editList["name"] = title;
      }
      if(this.formContact!=null && this.formContact.displayName!=""){
        Map<String,dynamic> _c = new Map<String,dynamic>();
        _c["id"] = formContact.identifier;
        _c["name"] = formContact.displayName;
        if(formContact is Contact &&  formContact.phones!=null && formContact.phones.length>=1) {
          _c["phone"] = formContact.phones.first.value;
        }
        if(formContact is Contact && formContact.emails !=null && formContact.emails.length>=1) {
          _c["email"] = formContact.emails.first.value;
        }
        editList["toContact"] = json.encode(_c);
        editList.remove("removeContact");
      }


      if(editList.length!=0 || _selectedImage!=null) {

        result = await _apiService.updateGift(
            editList,_edittingGift.id, currentUser,file:_selectedImage);
      }else{
        result = true;
      }
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create gift',
        description: result,
      );
    }
    //_navigationService.pop(result:"reload");
    //_navigationService.navigateTo(SavedGiftsViewRoute,arguments: true);
  }

  void setEdittingGift(Gift edittingGift) {
    _edittingGift = edittingGift;
    if(null != edittingGift){
      if(edittingGift.toContact!=null){
          this.formContact  = new Contact();
          this.formContact.identifier = edittingGift.toContact.id;
          this.formContact.displayName = edittingGift.toContact.name;
      }
    }
  }
  Path getClip(Size size) {
    var path = Path();
    var reactPath = Path();

    reactPath.moveTo(size.width / 4, size.height * 2 / 6);
    reactPath.lineTo(size.width * 3 / 4, size.height * 2 / 6);
    reactPath.lineTo(size.width * 3 / 4, size.height * 4 / 6);
    reactPath.lineTo(size.width / 4, size.height * 4 / 6);

    path.addPath(reactPath, Offset(0, 0));
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    path.fillType = PathFillType.evenOdd;
/*
    path.moveTo(size.width/4, size.height/4);
    path.lineTo(size.width/4, size.height*3/4);
    path.lineTo(size.width*3/4, size.height*3/4);
    path.lineTo(size.width*3/4, size.height/4);
*/
    path.close();
    return path;
  }

  Future selectImage(BuildContext context) async {
    editList.remove("removeImage");
   /* File file = await  Navigator.push(context, MaterialPageRoute(builder: (context) => Camera(  mode: CameraMode.normal,

      imageMask: IgnorePointer(
        child: ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(133, 30, 40, 255),
          ),
          clipper: _SquareModePhoto(),
        ),
      ),


    )));


    _selectedImage = file;*/
    _edittingGift.hasImage=true;
  }





}



class _SquareModePhoto extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var reactPath = Path();

    reactPath.moveTo(0, size.height * 1 / 4);
    reactPath.lineTo(size.width * 1, size.height * 1 / 4);
    reactPath.lineTo(size.width *1, size.height * 4 / 6);
    reactPath.lineTo(0, size.height * 4 / 6);

    path.addPath(reactPath, Offset(0, 0));
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    path.fillType = PathFillType.evenOdd;
/*
    path.moveTo(size.width/4, size.height/4);
    path.lineTo(size.width/4, size.height*3/4);
    path.lineTo(size.width*3/4, size.height*3/4);
    path.lineTo(size.width*3/4, size.height/4);
*/
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}