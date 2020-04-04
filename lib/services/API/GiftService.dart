import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/gift.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'GiftService.g.dart';


@RestApi(baseUrl: APISERVER)
abstract class GiftService {
  factory GiftService(Dio dio, {String baseUrl}) = _GiftService;


  @GET("/api/gifts/list")
  Future<List<Gift>> getGiftList();



  @POST("/api/gifts/update/{id}")
  Future<Gift> updateGift(@Path() int id,@Body() Gift gift);

  @POST("/api/gifts/add")
  Future<Gift> addGift(@Body() Gift gift);


  @GET("/api/gifts/remove/{id}")
  Future<void> delete(@Path() int id);

}