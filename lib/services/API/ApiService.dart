
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/models/user.dart';
import 'package:luvutest/services/API/UserService.dart';
import 'package:luvutest/services/authentication_service.dart';

import 'DioProvider.dart';
import 'GiftService.dart';

class ApiService{



  Future<User> createUser(User u){

      return new UserService(
          DioProvider.withAuth(u).getDio()
      ).getUser();

  }


  Future<Gift> updateGift(Gift gift,User u){
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).updateGift(gift.id,gift);
  }
  Future<void> deleteGift(Gift gift,User u) async{
    await  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).delete(gift.id);
  }

  Future<Gift> addGift(Gift gift,User u){

    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).addGift(gift);
  }


  Future <List<Gift>> getGifts(User u){

    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).getGiftList();
  }
/*
  Future <bool> deleteGift(Gift gift){
    User u = _authenticationService.currentUser;
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).deleteGift(gift.id);
  }

  Future <Gift> updateGift(Gift updatedGift){
    User u = _authenticationService.currentUser;
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).updateGift(updatedGift);
  }


  Future <bool> addGift(Gift gift){
    User u = _authenticationService.currentUser;
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).addGift(gift);
  }

  Future <bool> restoreGift(Gift gift){
    User u = _authenticationService.currentUser;
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).restoreGift(gift);
  }
*/


}