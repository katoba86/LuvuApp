
import 'dart:convert';
import 'dart:io';


import 'package:luvutest/models/Lists.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/models/user.dart';
import 'package:luvutest/services/API/ListService.dart';
import 'package:luvutest/services/API/UserService.dart';


import 'API/DioProvider.dart';
import 'API/GiftService.dart';

class ApiService{


  Future<User> createUser(User u){

      return new UserService(
          DioProvider.withAuth(u).getDio()
      ).getUser();

  }

  Future<Gift> updateGift(Map<String,String> editingList,int giftId,User u,{File file}){
    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).updateGift(giftId,json.encode(editingList),file:file);
  }
  Future<void> deleteGift(Gift gift,User u) async{
    await  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).delete(gift.id);
  }

  Future<Gift> addGift(Gift gift,User u,{File file}){

    return  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).addGift(gift,file: file);
  }


  Future <List<Gift>> getListGifts(Lists list,User u) async{
    List<Gift> gifts =  await  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).getGiftList();
    return gifts.where((Gift item){
      return (item.reference_to_group == list.id);
    }).toList();
  }

  Future <List<Gift>> getGifts(User u) async{

    List<Gift> gifts = await  new GiftService(
        DioProvider.withAuth(u).getDio()
    ).getGiftList();
    return gifts.where((Gift item){
      return (item.reference_to_group == null);
      //return item.reference_to_group = list.id;
    }).toList();
  }
  Future <List<Lists>> getLists(User u){

    return  new ListService(
        DioProvider.withAuth(u).getDio()
    ).getLists();
  }

}