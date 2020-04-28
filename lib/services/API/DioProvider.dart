import 'package:dio/dio.dart';
import 'package:luvutest/constants/config.dart';

import 'package:luvutest/models/user.dart';


class DioProvider {
  Dio dioInstance;



  bool hasAuth = false;

  String _token;

  Dio dio;

  DioProvider.withAuth(User user) {
    _token = user.token;
    hasAuth = true;
  }

  DioProvider.withOutAuth() {
    _token = "";
    hasAuth = false;
  }

  Dio getDio() {
    Dio d = Dio(new BaseOptions(
        baseUrl: APISERVER,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        followRedirects: true,
        contentType: "application/json",
        headers: (hasAuth) ? {"Authorization": "Bearer $_token"} : {}));

    d.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        print(
            "REQUEST[${options?.method}] => PATH: ${options?.baseUrl}${options?.path} => Headers: ${options?.headers.toString()}");

      print("Data send:");
        print(options.data);

        return options;
      },
      onResponse: (Response response) async {
        print("RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
        print(response.data.toString());
        return response;
      },
      onError: (DioError err){
        print("ERROR[${err.message}]");

        return err;
      }
    ));

    return d;
  }
}
