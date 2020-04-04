// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserService implements UserService {
  _UserService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://luvu.ngrok.io';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return Future.value(value);
  }
}
