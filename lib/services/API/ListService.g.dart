// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ListService implements ListService {
  _ListService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://luvu.ngrok.io/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Lists>> getLists() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/group/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Lists.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Lists> addGroup(list) async {
    ArgumentError.checkNotNull(list, 'list');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(list?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/group/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Lists.fromJson(_result.data);
    return value;
  }
}
