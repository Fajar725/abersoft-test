import 'package:abersoft_test/infra/api/dio_config.dart';
import 'package:dio/dio.dart';

class DioOptions {
  static Dio? _dio;
  static DioOptions? _dioOptions;

  DioOptions._(){
    _dio ??= DioConfig();
  }

  static DioOptions init(){
    _dioOptions ??= DioOptions._();

    return _dioOptions!;
  }

  Future<Response> getWithAuthParam(String path, String auth, {Map<String, dynamic>? queryParam}) {
    return _dio!.get(path, options : Options(headers: {"Authorization": "Bearer $auth"}), queryParameters: queryParam);
  }

  Future<Response> getWithJsonParam(String path, {Map<String, dynamic>? queryParam}) {
    return _dio!.get(path, queryParameters: queryParam);
  }

  Future<Response> postWithAuthJson(String path, String auth, {Map<String, dynamic>? json}) {
    return _dio!.post(path, options : Options(headers: {"Authorization": "Bearer $auth", "Content-Type": "application/json"}), data: json);
  }

  Future<Response> postWithJson(String path, {Map<String, dynamic>? json}) {
    return _dio!.post(path, options: Options(headers: {"Content-Type": "application/json"}), data: json);
  }

  Future<Response> postWithAuthFormData(String path, String auth, {FormData? formData}) {
    return _dio!.post(
      path, 
      options : Options(headers: {"Authorization": "Bearer $auth", "Content-Type": "multipart/form-data"}),
      data: formData);
  }

}