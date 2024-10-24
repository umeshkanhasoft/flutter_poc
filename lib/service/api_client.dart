import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart' as getx;
import 'package:test_22_10_2024/routes/app_routes.dart';
import 'package:test_22_10_2024/service/base_response.dart';
import 'package:test_22_10_2024/utils/env.dart';
import 'package:test_22_10_2024/utils/shared_preferences.dart';
import 'package:test_22_10_2024/widget/loader.dart';

class ApiClient {
  Dio? _dio;
  static final ApiClient instance = ApiClient._internal();

  ApiClient._internal() {
    setUpClient();
  }

  setUpClient() {
    _dio = Dio(BaseOptions(
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(minutes: 5),
        responseType: ResponseType.plain,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }));
    // ignore: deprecated_member_use
    (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var interceptor = InterceptorsWrapper(
      onRequest: (request, handler) async {
        String? cookieValue = await SharedPreferencesService().getSessionId();
        if (cookieValue?.isNotEmpty == true) {
          request.headers['cookie'] = cookieValue;
        }
        handler.next(request);
      },
      onResponse: (response, handler) {
        final cookies = response.headers.map['set-cookie'];
        if (cookies?.isNotEmpty == true) {
          cookies?[0].split(';').forEach((element) {
            if (element.startsWith('session_id=')) {
              saveSessionIDinSharedPreference(element);
            }
          });
        }
        handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    );
    _dio?.interceptors.add(interceptor);
    _dio?.interceptors.add(CookieManager(CookieJar()));
  }

  Future<Response?> downloadFile(url, savePath) async {
    Response<dynamic>? response = await _dio?.download(
      url,
      savePath,
    );

    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.writeOnlyAppend);
    raf.writeFromSync(response?.data);
    await raf.close();
    return response;
  }

  saveSessionIDinSharedPreference(String? sessionId) async {
    await SharedPreferencesService().setSessionId(sessionId!);
  }

  showLoader() {
    return const LoaderOverlay();
  }

  Future<ApiResponse>? call(
      {String? url,
      String? baseUrl,
      Map<String, dynamic>? param,
      Map<String, dynamic>? queryParams,
      ApiMethod method = ApiMethod.GET,
      FormData? fileUploadData,
      Map<String, dynamic>? mHeader,
      fromUrlEncode = false,
      CancelToken? cancelToken,
      Function(int sentBytes, int totalBytes)? onProgress,
      String? token}) async {
    try {
      if (await isConnectionAvailable()) {
        url = baseUrl != null ? "$baseUrl$url" : "${Environment.apiUrl}$url";
        mHeader ??= <String, dynamic>{};
        mHeader = await commonHeaderForApp(mHeader, method);

        Response? response;
        switch (method) {
          case ApiMethod.GET:
            response = await _dio?.get(url,
                queryParameters: queryParams,
                data: param,
                options: Options(headers: mHeader));
            break;
          case ApiMethod.POST:
            response = await _dio?.post(
              url,
              data: param,
              queryParameters: queryParams,
              options: Options(headers: mHeader),
            );
            break;
          case ApiMethod.PUT:
            response = await _dio?.put(url,
                queryParameters: queryParams,
                data: param,
                options: Options(headers: mHeader));
            break;
          case ApiMethod.PATCH:
            response = await _dio?.patch(url,
                data: param, options: Options(headers: mHeader));
            break;
          case ApiMethod.DELETE:
            response = await _dio?.delete(url,
                queryParameters: queryParams,
                data: param,
                options: Options(headers: mHeader));
            break;
          case ApiMethod.MULTIPART:
            response = await _dio?.post(
              url,
              data: fileUploadData,
              queryParameters: queryParams,
              options: Options(headers: mHeader),
              cancelToken: cancelToken,
              onSendProgress: (int sentBytes, int totalBytes) {
                onProgress != null ? onProgress(sentBytes, totalBytes) : null;
              },
            );
            break;
          default:
            return ApiResponse.parsing(
                null, 'You have set wrong http method', false);
        }
        if (response != null) {
          Map<String, dynamic> responseMap = {};
          if (response.data is Map) {
            responseMap = response.data;
          } else {
            responseMap = jsonDecode(response.data);
          }

          if (responseMap.containsKey('error') &&
              responseMap['error'] == 'user not authorized') {
            await SharedPreferencesService().clear();
            getx.Get.offAllNamed(AppRoutes.welcome);
          }
          if (response.statusCode! >= 200 && response.statusCode! <= 299) {
            return ApiResponse.parsing(
                (responseMap.containsKey('data') && responseMap['data'] != null)
                    ? responseMap['data']
                    : null,
                (responseMap.containsKey('error') &&
                        responseMap['error'] != null)
                    ? responseMap['error']
                    : '',
                (responseMap.containsKey('status') &&
                        responseMap['status'] != null)
                    ? responseMap['status']
                    : true);
          } else {
            return ApiResponse.parsing(
                null, responseMap['error'] ?? response.statusMessage, false);
          }
        } else {
          return ApiResponse.parsing(null, 'Something went wrong...', false);
        }
      } else {
        return ApiResponse.parsing(null, 'No internet connection', false);
      }
    } on Exception catch (e) {
      return ApiResponse.parsing(null, e.toString(), false);
    }
  }

  Future<Map<String, dynamic>>? commonHeaderForApp(
      Map<String, dynamic> header, ApiMethod method) async {
    if (!header.containsKey('content-type') && method != ApiMethod.MULTIPART) {
      header['content-type'] = 'application/json; charset=UTF-8';
    }
    return header;
  }
}

// ignore: constant_identifier_names
enum ApiMethod { GET, POST, MULTIPART, DELETE, PUT, PATCH }

class ErrorCode {
  // ignore: constant_identifier_names
  static const INTERNAL_SERVER_ERROR = 500;

  // ignore: constant_identifier_names
  static const NO_INTERNET_CONNECTION = 502;
}

Future<bool> isConnectionAvailable() async {
  var result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}
