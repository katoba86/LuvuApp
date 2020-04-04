// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GiftService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GiftService implements GiftService {
  _GiftService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://luvu.ngrok.io';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getGiftList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/api/gifts/list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Gift.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  updateGift(id, gift) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(gift, 'gift');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(gift?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/gifts/update/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Gift.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  addGift(gift) async {
    ArgumentError.checkNotNull(gift, 'gift');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(gift?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/gifts/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Gift.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  delete(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/api/gifts/remove/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }
}
