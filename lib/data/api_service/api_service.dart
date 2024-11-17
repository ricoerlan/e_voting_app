import 'package:dio/dio.dart';
import 'package:e_voting/data/api_service/api.dart';

class ApiService {
  static ApiService? _instance;

  Api api = Api();

  factory ApiService() => _instance ?? ApiService._();

  ApiService._();

  Future<Response<T>> get<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await api.dio
        .get<T>(url, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> post<T>(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    return await api.dio.post(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    return await api.dio.put(url,
        data: data, queryParameters: queryParameters, options: options);
  }
}
