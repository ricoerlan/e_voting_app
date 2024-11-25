import 'package:dio/dio.dart';
import 'package:e_voting/core/constant.dart';

class Api {
  Dio?
      _dio; // Private variable untuk menyimpan instance Dio, yang akan digunakan untuk melakukan request HTTP.

  // Getter untuk mendapatkan instance Dio.
  Dio get dio {
    // Jika instance Dio sudah ada, kembalikan instance tersebut.
    if (_dio != null) {
      return _dio!;
    } else {
      // Jika instance Dio belum ada, buat instance baru dengan konfigurasi dasar.
      var dio = Dio(
        BaseOptions(
          // Pengaturan header default untuk request
          headers: {
            "Accept":
                "application/json", // Mengatur jenis konten yang diterima adalah JSON.
            "Content-Type":
                "application/json" // Mengatur jenis konten yang dikirim adalah JSON.
          },
          baseUrl: baseUrl, // Menentukan base URL untuk semua request API.
          receiveTimeout:
              const Duration(seconds: 45), // Timeout untuk menerima response.
          connectTimeout: const Duration(
              seconds: 250), // Timeout untuk menghubungkan ke server.
          sendTimeout:
              const Duration(seconds: 45), // Timeout untuk mengirim data.
          followRedirects: true, // Mengikuti redirect jika ada.
          validateStatus: (statusCode) {
            // Fungsi untuk memvalidasi status code dari response. Return true untuk semua status code.
            return true;
          },
        ),
      );
      // Menambahkan interceptor untuk menangani error secara global.
      dio.interceptors
          .add(InterceptorsWrapper(onError: (DioException e, handler) {
        // Jika terjadi error pada request, reject error tersebut.
        return handler.reject(e);
      }));
      // Menyimpan instance Dio yang telah dikonfigurasi dan mengembalikannya.
      _dio = dio;
      return dio;
    }
  }

  // Private constructor untuk memastikan kelas ini hanya memiliki satu instance (singleton).
  Api._internal();

  // Instance singleton yang digunakan di seluruh aplikasi.
  static final _singleton = Api._internal();

  // Factory constructor untuk memastikan hanya ada satu instance dari Api.
  factory Api() => _singleton;
}
