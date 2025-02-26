import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/error_response.dart';
import '../utils/session_manager.dart';
import 'api_config.dart';

class ApiClient {
  final GetStorage? sharedPreferences;
  static const String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 30;
  String? token;
  String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({this.appBaseUrl = ApiConfig.baseUrl, this.sharedPreferences}) {
    if (sharedPreferences != null) {
      token = sharedPreferences!.read(kUserName);
      if (kDebugMode) {
        debugPrint('Token: $token');
      }
      updateHeader(token: token);
    } else {
      updateHeader();
    }
  }

  void updateHeader({String? token, bool? multipart}) async {
    if (multipart ?? false) {
      _mainHeaders = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } else {
      _mainHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      Uri fullUri = Uri.parse(appBaseUrl + uri).replace(queryParameters: query);
      if (kDebugMode) {
        debugPrint('====> API Base url: $appBaseUrl');
        debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .get(
            fullUri,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers,
      bool? isConvert = true,
      bool isPrint = false,}) async {
    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $appBaseUrl$uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: isConvert! ? jsonEncode(body) : body,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (_) {
      return Response(noInternetMessage, 0);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    updateHeader(token: token, multipart: true);
    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body with ${multipartBody.length} files');
      }
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: '${DateTime.now().toString()}.webp',
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers, bool? isConvert = true}) async {
    try {
      if (kDebugMode) {
        debugPrint(
            '====> API Call: ${appBaseUrl + uri}\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response response = await http
          .patch(
            Uri.parse(appBaseUrl + uri),
            body: isConvert! ? jsonEncode(body) : body,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> Error: $e');
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Future<Response> patchMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    updateHeader(token: token, multipart: true);
    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body with ${multipartBody.length} files');
      }

      var request = http.MultipartRequest('PATCH', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);

      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          String extension = multipart.file!.path.split('.').last;
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: '${DateTime.now().millisecondsSinceEpoch}.$extension',
            contentType: MediaType('image', 'png'),
          ));
        }
      }

      request.fields.addAll(body);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return handleResponse(response, uri);
    } catch (e) {
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(
        noInternetMessage,
        0,
      );
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    Response response0;
    try {
      response0 = Response(
        response.body,
        response.statusCode,
      );
    } catch (_) {
      body = jsonDecode(response.body);
      response0 = Response(
        jsonEncode(body ?? response.body),
        response.statusCode,
      );
    }
    if (response0.statusCode != 200 && response0.statusCode != 201) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(json.decode(response0.body));
        response0 = Response(errorResponse.message ?? '', response0.statusCode);
      } else if (response0.statusCode == 401) {
        sharedPreferences?.write(kUserName, "");
        try {
          response0 = Response(
              json.decode(response0.body)["message"], response0.statusCode);
        } catch (_) {}
      } else {
        try {
          response0 = Response(body["message"], response0.statusCode);
        } catch (_) {
          response0 = Response(
              jsonDecode(response.body)['message'], response0.statusCode);
        }
      }
    } else if (response0.statusCode != 200 &&
        response0.statusCode != 201 &&
        response0.body == null) {
      response0 = Response(noInternetMessage, 0);
    }
    if (kDebugMode) {
      debugPrint(
          '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
