import 'package:dio/dio.dart';
import 'package:e_voting/data/api_service/api.dart';

class ApiService {
  static ApiService?
      _instance; // Menyimpan instance dari ApiService. Ini digunakan untuk memastikan hanya ada satu instance (singleton) dari ApiService.

  Api api =
      Api(); // Instance dari kelas Api yang digunakan untuk berinteraksi dengan API melalui Dio.

  // Factory constructor untuk mengimplementasikan pattern singleton.
  factory ApiService() =>
      _instance ??
      ApiService
          ._(); // Jika _instance null, buat instance baru, jika sudah ada, gunakan instance yang sudah ada.

  // Private constructor untuk mencegah instansiasi langsung di luar kelas.
  ApiService._();

  // Fungsi untuk melakukan HTTP GET request.
  Future<Response<T>> get<T>(
    String url, {
    dynamic
        data, // Data yang dikirim dalam request body (biasanya null untuk GET).
    Map<String, dynamic>?
        queryParameters, // Parameter query yang dikirim dalam URL.
  }) async {
    return await api.dio.get<T>(url,
        queryParameters: queryParameters,
        data:
            data); // Melakukan GET request menggunakan Dio dan mengembalikan Response.
  }

  // Fungsi untuk melakukan HTTP POST request.
  Future<Response<T>> post<T>(String url,
      {dynamic data, // Data yang dikirim dalam body request.
      Map<String, dynamic>? queryParameters, // Parameter query untuk URL.
      Options? options}) async {
    // Opsi tambahan untuk request, seperti header, timeout, dll.
    return await api.dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options:
            options); // Melakukan POST request menggunakan Dio dan mengembalikan Response.
  }

  // Fungsi untuk melakukan HTTP PUT request.
  Future<Response<T>> put<T>(String url,
      {dynamic data, // Data yang dikirim dalam body request.
      Map<String, dynamic>? queryParameters, // Parameter query untuk URL.
      Options? options}) async {
    // Opsi tambahan untuk request, seperti header, timeout, dll.
    return await api.dio.put(url,
        data: data,
        queryParameters: queryParameters,
        options:
            options); // Melakukan PUT request menggunakan Dio dan mengembalikan Response.
  }
}
