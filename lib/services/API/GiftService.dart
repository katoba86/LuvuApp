import 'dart:convert';
import 'dart:io';

import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/gift.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'GiftService.g.dart';


@RestApi(baseUrl: APISERVER)
abstract class GiftService {
  factory GiftService(Dio dio, {String baseUrl}) = _GiftService;


  @GET("/gift/list")
  Future<List<Gift>> getGiftList();



  @POST("/gift/update/{id}")
  Future<Gift> updateGift(@Path() int id,@Part() String gift,{@Part() File file});

  @POST("/gift/add")
  Future<Gift> addGift(@Part() Gift gift,{@Part() File file});



  @GET("/gift/remove/{id}")
  Future<void> delete(@Path() int id);

}