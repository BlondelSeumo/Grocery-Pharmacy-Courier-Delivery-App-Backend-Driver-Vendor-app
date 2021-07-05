import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fuodz/constants/api.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.service.dart';
import 'local_storage.service.dart';

class HttpService {
  String host = Api.baseUrl;
  BaseOptions baseOptions;
  Dio dio;
  SharedPreferences prefs;

  Future<Map<String, String>> getHeaders() async {
    final userToken = await AuthServices.getAuthBearerToken();
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken",
    };
  }

  HttpService() {
    LocalStorageService.getPrefs();

    baseOptions = new BaseOptions(
      baseUrl: host,
      validateStatus: (status) {
        return status <= 500;
      },
      // connectTimeout: 300,
    );
    dio = new Dio(baseOptions);
    dio.interceptors.add(DioCacheManager(
      CacheConfig(
        baseUrl: host,
        defaultMaxAge: Duration(hours: 1),
      ),
    ).interceptor);
    // customization
    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: false,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 90,
    //   ),
    // );
  }

  //for get api calls
  Future<Response> get(
    String url, {
    Map<String, dynamic> queryParameters,
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    return dio.get(
      uri,
      options: mOptions,
      queryParameters: queryParameters,
    );
  }

  //for post api calls
  Future<Response> post(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    return dio.post(
      uri,
      data: body,
      options: mOptions,
    );
  }

  //for post api calls with file upload
  Future<Response> postWithFiles(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    var response = Response();

    try {
      response = await dio.post(
        uri,
        data: FormData.fromMap(body),
        options: mOptions,
      );
    } catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }

  //for patch api calls
  Future<Response> patch(String url, Map<String, dynamic> body) async {
    String uri = "$host$url";
    return dio.patch(
      uri,
      data: body,
      options: Options(
        headers: await getHeaders(),
      ),
    );
  }

  //for delete api calls
  Future<Response> delete(
    String url,
  ) async {
    String uri = "$host$url";
    return dio.delete(
      uri,
      options: Options(
        headers: await getHeaders(),
      ),
    );
  }

  Response formatDioExecption(ex) {
    var response = Response();
    response.statusCode = 400;
    try {
      if (ex.type == DioErrorType.CONNECT_TIMEOUT) {
        response.data = {
          "message":
              "Connection timeout. Please check your internet connection and try again",
        };
      } else {
        response.data = {
          "message": ex.message ??
              "Please check your internet connection and try again",
        };
      }
    } catch (error) {
      final response = Response();
      response.statusCode = 400;
      response.data = {
        "message": error.message ??
            "Please check your internet connection and try again",
      };
    }

    return response;
  }
}
