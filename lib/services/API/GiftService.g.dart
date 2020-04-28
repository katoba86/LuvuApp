// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GiftService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GiftService implements GiftService {
  _GiftService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://luvu.ngrok.io/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getGiftList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/gift/list',
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
  updateGift(id, gift, {file}) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(gift, 'gift');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (gift != null) {
      _data.fields.add(MapEntry('gift', gift));
    }
    if (file != null) {
      _data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split(Platform.pathSeparator).last)));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/gift/update/$id',
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
  addGift(gift, {file}) async {
    ArgumentError.checkNotNull(gift, 'gift');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('gift', jsonEncode(gift ?? <String, dynamic>{})));
    if (file != null) {
      _data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(file.path,
              filename: file.path.split(Platform.pathSeparator).last)));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/gift/add',
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
    await _dio.request<void>('/gift/remove/$id',
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
