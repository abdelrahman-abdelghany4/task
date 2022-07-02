import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://magdsoft-internship.herokuapp.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
    };
    return await dio!.put(
      url,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required String token,
  }) async {
    dio!.options.headers = {
      'Authorization': token,
    };
    return await dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
//'http://10.0.2.2:8000/'
