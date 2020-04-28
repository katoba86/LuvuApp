import 'dart:io';
import 'package:camera_camera/page/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/models/GiftContact.dart';

import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/ui/views/mygifts/myGifts_view.dart';
import 'package:luvutest/viewmodels/base_model.dart';

import '../locator.dart';

class AddGiftViewModel extends BaseModel{
  String _platformMessage = 'Unknown';
  String _camera = 'fromCameraCropImage';
  String _gallery = 'fromGalleryCropImage';
  File _selectedImage;
  File get selectedImage => _selectedImage;
  final ApiService _apiService = new ApiService();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Map<String,String> editList = new Map<String,String>();


  Gift _edittingGift;
  bool get _editting => _edittingGift != null && _edittingGift.id!=null;

  void removeImage(){
    this._edittingGift.hasImage=false;
    editList["removeImage"] = "true";
    if(this.selectedImage!=null){
      this._selectedImage=null;
    }
    this.notifyListeners();
  }


  Gift getGift(){
    return this._edittingGift;
  }

  void setEdittingGift(Gift edittingGift) {
    _edittingGift = edittingGift;
    if(null != edittingGift){
      if(edittingGift.toContact!=null){

      }
    }
  }

  Future addGift() async {
    setBusy2(true);

    var result;
    print(_editting);

    if (!_editting) {
      result = await _apiService.addGift(
          Gift(name: editList["name"], id: null), currentUser,
          file: _selectedImage);
      _navigationService.navigateTo(SavedGiftsViewRoute,arguments: true);
    }
    setBusy2(false);
  }


    Future selectImage(BuildContext context) async {
    editList.remove("removeImage");
    File file = await  Navigator.push(context, MaterialPageRoute(builder: (context) => Camera(  mode: CameraMode.normal,

      imageMask: IgnorePointer(
        child: ClipPath(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xCC657825),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

          ),
          clipper: _SquareModePhoto(),
        ),
      ),


    )));


    _selectedImage = file;

 //   _selectedImage = new File(result);

    _edittingGift.hasImage=true;
  }

}


class _SquareModePhoto extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var reactPath = Path();

    double w = size.width;
    double h = size.height;


    reactPath.moveTo(0, (h/2)-(w/2));
    reactPath.lineTo(size.width * 1, (h/2)-(w/2));
    reactPath.lineTo(size.width *1, (h/2)+(w/2));
    reactPath.lineTo(0, (h/2)+(w/2));

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