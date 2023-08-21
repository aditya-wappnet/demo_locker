import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../managers/authentication_manager.dart';

var baseUrl = "";

class ApiClient {
  static Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 60000),
      connectTimeout: const Duration(milliseconds: 30000),
      followRedirects: false,
      headers: {
        'Accept': "application/json",
      },
      validateStatus: (status) {
        log("@@status : $status");
        return status! < 500;
      }));

  setBaseToken(token) {
    dio.options.headers.putIfAbsent("Authorization", () => "Bearer $token");
  }

  setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            RequestOptions originalRequest = response.requestOptions;
            // Throw an error to trigger the onError callback
            throw DioException(
              requestOptions: originalRequest,
              response: response,
              error: 'Unauthorized',
              type: DioExceptionType.badResponse,
            );
          }
          // Add your custom logic here for response interception
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            removeBaseToken();
            if (Get.isRegistered<AuthenticationManager>()) {
              final auth = Get.find<AuthenticationManager>();
              auth.logOut();
            }
          }
          // Handle other errors if needed
          return handler.next(error);
        },
      ),
    );
  }

  removeBaseToken() {
    dio.options.headers.remove("Authorization");
  }

  Future<Response?> get(
    String url, {
    dynamic param,
  }) async {
    try {
      Response response = await dio.get(baseUrl + url, queryParameters: param);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
          return Response(
              statusCode: e.response!.statusCode,
              statusMessage: "Interval Server Error",
              requestOptions: e.response!.requestOptions,
              data: null);
        }
      } else {
        log("Get Error=>${e.message}");
      }
    }
    return null;
  }

  Future<Response?> post(
    String url, {
    Map<String, dynamic>? jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.post(baseUrl + url, data: jsonData, queryParameters: param);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
      } else {
        log("Post Error=>${e.message}");

        return Response(
            statusCode: e.response?.statusCode,
            statusMessage: e.message,
            requestOptions: e.requestOptions);
      }
    }
    return null;
  }

  Future<Response?> patch(
    String url, {
    required Map<String, dynamic> jsonData,
    dynamic param,
  }) async {
    try {
      Response response = await dio.patch(baseUrl + url,
          data: jsonData, queryParameters: param);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(e.response!.data);
      } else {
        log("Patch Error=>${e.message}");
      }
    }
    return null;
  }

  Future<Response?> put(
    String url, {
    required Map<String, dynamic> jsonData,
    dynamic param,
  }) async {
    try {
      Response response =
          await dio.put(baseUrl + url, data: jsonData, queryParameters: param);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(e.response!.data);
      } else {
        log("put Error=>${e.message}");
      }
    }
    return null;
  }

  Future<Response?> delete({
    required String url,
    Map<String, dynamic>? jsonData,
    dynamic param,
  }) async {
    try {
      Response response = await dio.delete(baseUrl + url,
          queryParameters: param, data: jsonData);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log(e.response!.data);
      } else {
        log("Delete Error=>${e.message}");
      }
    }
    return null;
  }

  getImageLoadUrl(String path) {
    return "${baseUrl}user/$path";
  }

  Future<Response?> sendFile(
    String url, {
    required FormData jsonData,
    dynamic param,
  }) async {
    jsonData;
    try {
      Response response = await dio.post(baseUrl + url, data: jsonData);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
            statusCode: e.response!.statusCode,
            statusMessage: e.response!.data['message'],
            requestOptions: e.response!.requestOptions,
            data: e.response!.data);
      } else {
        return Response(
            statusCode: e.response?.statusCode,
            statusMessage: e.message,
            requestOptions: e.requestOptions);
      }
    }
  }

  Future<Response?> patchFile(
    String url, {
    required FormData jsonData,
    dynamic param,
  }) async {
    jsonData;
    try {
      Response response = await dio.patch(baseUrl + url, data: jsonData);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return Response(
            statusCode: e.response!.statusCode,
            statusMessage: e.response!.data['message'],
            requestOptions: e.response!.requestOptions,
            data: e.response!.data);
      } else {
        return Response(
            statusCode: e.response!.statusCode,
            statusMessage: e.message,
            requestOptions: e.requestOptions);
      }
    }
  }
}
