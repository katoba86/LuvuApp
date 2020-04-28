import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'UserService.g.dart';


@RestApi(baseUrl: APISERVER)
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;


  @GET("/user")
  Future<User> getUser();


}