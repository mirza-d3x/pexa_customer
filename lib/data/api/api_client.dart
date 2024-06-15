import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shoppe_customer/data/models/error_response.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  final Logger _logger = Logger();
  String? token;
  Map<String, String>? _mainHeaders;
  final box = GetStorage();
  final boxId = GetStorage();
  final boxPhone = GetStorage();
  final boxDefaultAddress = GetStorage();

  ApiClient({required this.appBaseUrl}) {
    token = box.read('userToken');
    debugPrint('Token: $token');
    updateHeader(token, box.read(AppConstants.LANGUAGE_CODE));
  }

  void updateHeader(String? token, String? languageCode) {
    if (token != null) {
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.LOCALIZATION_KEY:
            languageCode ?? AppConstants.languages[0].languageCode!,
        'Authorization': 'Bearer $token',
        // "Access-Control-Allow-Origin": "*",
        // 'Accept': '*/*'
      };
    } else {
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.LOCALIZATION_KEY:
            languageCode ?? AppConstants.languages[0].languageCode!,
        // "Access-Control-Allow-Origin": "*",
        // 'Accept': '*/*'
      };
    }
  }

  Future<Response> getData(
      {required String uri,
      Map<String, dynamic>? query,
      Map<String, String>? headers}) async {
    late http.Response response;
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.d(
          "Request: ${appBaseUrl + uri} \n query: $query \n header: $headers");
      response = await http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      );
      return handleResponse(response, uri);
    } catch (e) {
      _logger.e(e);
      return handleResponse(response, uri);
    }
  }

  Future<Response> postData(
      {required String uri, dynamic body, Map<String, String>? headers}) async {
    var response;
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.d('====> API Body: $body');
      _logger
          .d("Request: ${appBaseUrl + uri} \n body: $body \n header: $headers");
      String encBody = "";
      if (body != null) {
        encBody = jsonEncode(body);
      }
      _logger.i('===> encoded JSON: $encBody');
      var response = await http.post(
        Uri.parse(appBaseUrl + uri),
        body: encBody,
        headers: headers ?? _mainHeaders,
      );
      _logger.i('===> RESPONSE JSON: ${response.body}');
      return handleResponse(response, uri);
    } catch (e) {
      _logger.e(e);
      return handleResponse(response, uri);
    }
  }

  Future<Response> postMultipartData(
      {required String uri,
      required Map<String, String> body,
      required List<MultipartBody> multipartBody,
      Map<String, String>? headers}) async {
    late http.Response response;
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.i('====> API Body: $body');
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders as Map<String, String>);
      for (MultipartBody multipart in multipartBody) {
        if (foundation.kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            list.length,
            filename: basename(multipart.file.path),
            contentType: MediaType('image', 'jpg'),
          );
          request.files.add(part);
        } else {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      _logger.e(e);
      return handleResponse(response, uri);
    }
  }

  Future<Response> putData(
      {required String uri,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    late http.Response response;
    try {
      String encBody = "";
      if (body != null) {
        encBody = jsonEncode(body);
      }
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.i('====> API Body: $body');
      _logger
          .d("Request: ${appBaseUrl + uri} \n body: $body \n header: $headers");
      response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: encBody,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      _logger.e(e);
      return handleResponse(response, uri);
    }
  }

  Future<Response> deleteData(
      {required String uri, Map<String, String>? headers}) async {
    late http.Response response;
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      _logger.e(e);
      return handleResponse(response, uri);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    _logger.d("BODY === ${response.body}");
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.statusCode != 201 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.statusCode == 500) {
        if (response0.body['message'].isNotEmpty) {
          showCustomSnackBar(response0.body['message'], isError: true);
        } else {
          showCustomSnackBar(response0.statusText, isError: true);
        }
      }
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    _logger.d(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
