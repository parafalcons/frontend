import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

enum _Method { Get, Post, Put }

class ApiService {
  static Map<String, String> allHeaders = <String, String>{
    "Connection": "keep-alive",
  };

  // setting this class as a singleton
  static final ApiService _apiServce = ApiService._internal();

  factory ApiService() {
    return _apiServce;
  }

  ApiService._internal();

  Future<dynamic> get(Uri url,
      {Map<String, dynamic>? queries,
        Map<String, String>? headers,
        Object? body}) async {
    return await _call(_Method.Get, url,
        queries: queries, headers: headers, body: body);
  }

  Future<dynamic> post(Uri url,
      {Map<String, dynamic>? queries,
        Map<String, String>? headers,
        Object? body}) async {
    return await _call(_Method.Post, url,
        queries: queries, headers: headers, body: body);
  }

  Future<dynamic> put(Uri url,
      {Map<String, dynamic>? queries,
        Map<String, String>? headers,
        Object? body}) async {
    return await _call(_Method.Put, url,
        queries: queries, headers: headers, body: body);
  }

  Future<dynamic> _call(_Method method, Uri url,
      {Map<String, dynamic>? queries,
        Map<String, String>? headers,
        Object? body}) async {
    try {
      if (headers != null) {
        allHeaders.addAll(headers);
      }

      Dio dio = Dio();
      late Response response;

      switch (method) {
        case _Method.Get:
          response = await dio.get(
            url.toString(),
            queryParameters: queries,
            options: Options(headers: allHeaders),
          );
          break;
        case _Method.Post:
          response = await dio.post(
            url.toString(),
            queryParameters: queries,
            data: body,
            options: Options(headers: allHeaders),
          );
          break;
        case _Method.Put:
          response = await dio.put(
            url.toString(),
            queryParameters: queries,
            data: body,
            options: Options(headers: allHeaders),
          );
          break;
        default:
          break;
      }
      print(response.data);
      if (response.data is String) {
        String responseString = response.data
            .trim(); // Trim to remove extra spaces or new lines
        return responseString;
      } else if (response.data is Map) {
        return response.data;
      } else if (response.data is bool) {
        return response.data;
      } else if (response.data is List) {
        // Handle the list of videos
        List<dynamic> videoList = response.data;
        // Process the video list as needed
        return videoList;
      } else {
        throw Exception('Unsupported data type');
      }
    } catch (error) {
      print(error);

      if (error is DioException) {
        return error;
      } else {
        rethrow;
      }
    }
  }
}

