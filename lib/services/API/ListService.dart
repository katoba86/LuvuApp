import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/Lists.dart';
import 'package:luvutest/models/gift.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ListService.g.dart';


@RestApi(baseUrl: APISERVER)
abstract class ListService {
  factory ListService(Dio dio, {String baseUrl}) = _ListService;


  @GET("/group/list")
  Future<List<Lists>> getLists();


  @POST("/group/add")
  Future<Lists> addGroup(@Body() Lists list);



}