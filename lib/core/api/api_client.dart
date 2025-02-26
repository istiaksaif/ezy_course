import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../route/app_routes.dart';
import '../../transition/fade_transition.dart';
import '../utils/session_manager.dart';

class ApiClient {
  final String appBaseUrl;
  static const String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 30;

  String accessToken = '';
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    accessToken = SessionManager.getValue(kToken, value: '');
    updateHeader(token: accessToken);
  }

  void removeToken() {
    accessToken = '';
  }

  void updateHeader({String? token, bool? multipart}) async {
    if (accessToken.isEmpty && token != null) {
      accessToken = token;
    }
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
        'Authorization': 'Bearer $accessToken',
      };
    }
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    bool isAutoLogout = false,
  }) async {
    try {
      Uri fullUri =
          Uri.parse('$appBaseUrl$uri').replace(queryParameters: query);
      if (kDebugMode) {
        debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders');
      }
      http.Response response = await http
          .get(
            fullUri,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(
        response,
        uri,
        isAutoLogout: isAutoLogout,
      );
    } catch (e) {
      debugPrint('====> $e');
      if (e is SocketException || e.toString().contains('No Internet')) {
        return Response(
          noInternetMessage,
          0,
        );
      } else {
        return Response(
          'Something went wrong! try again later',
          -1,
        );
      }
    }
  }

  Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
    bool? isConvert = true,
    String? differBaseUrl,
  }) async {
    if (_mainHeaders['Content-Type']?.contains('multipart/form-data') == true) {
      updateHeader();
    }

    try {
      if (kDebugMode) {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        debugPrint('====> API Body: $body');
      }
      http.Response response = await http
          .post(
            Uri.parse((differBaseUrl ?? appBaseUrl) + uri),
            body: isConvert! ? jsonEncode(body) : body,
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(
        response,
        uri,
      );
    } catch (_) {
      return Response(noInternetMessage, 0);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, dynamic> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers, bool needWatermark = false}) async {
    updateHeader(token: accessToken, multipart: true);
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
          // if (!needWatermark) {
          String extension = multipart.file!.path.split('.').last;
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: '${DateTime.now().millisecondsSinceEpoch}.$extension',
            contentType: MediaType('image', 'webp'),
          ));
        }
      }
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

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
    updateHeader(token: accessToken, multipart: true);
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

  Response handleResponse(
    http.Response response,
    String uri, {
    bool isAutoLogout = true,
  }) {
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
      if (response0.statusCode == 401 &&
          Get.currentRoute != Routes.loginRoute) {
        if (isAutoLogout) {
          accessToken = '';
          SessionManager.logout();
          const FadeScreenTransition(
            routeName: Routes.loginRoute,
            replace: true,
          ).navigate();
        }
      } else {
        response0 = Response(response0.body, response0.statusCode);
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

  Future<Uint8List?> addWatermark(Uint8List imageBytes) async {
    // Load the watermark image from assets
    final ByteData watermarkData =
        await rootBundle.load('assets/images/watermark_image.webp');
    final Uint8List watermarkBytes = watermarkData.buffer.asUint8List();

    // Decode both the original and watermark images to ensure proper handling
    ui.Codec originalCodec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo originalFrame = await originalCodec.getNextFrame();

    ui.Codec watermarkCodec = await ui.instantiateImageCodec(watermarkBytes);
    ui.FrameInfo watermarkFrame = await watermarkCodec.getNextFrame();

    // Get dimensions for both images
    int originalWidth = originalFrame.image.width;
    int originalHeight = originalFrame.image.height;
    int watermarkWidth = watermarkFrame.image.width;
    int watermarkHeight = watermarkFrame.image.height;

    // Scale watermark to cover the full image
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
        recorder,
        Rect.fromPoints(Offset(0, 0),
            Offset(originalWidth.toDouble(), originalHeight.toDouble())));

    // Draw the original image first
    canvas.drawImage(originalFrame.image, Offset.zero, ui.Paint());

    // Scale the watermark to cover the full size of the original image
    ui.Paint paint = ui.Paint();
    paint.isAntiAlias = true;

    // Draw the watermark with transparency (alpha blending)
    final Rect watermarkRect = Rect.fromLTWH(
        0, 0, originalWidth.toDouble(), originalHeight.toDouble());

    canvas.drawImageRect(
        watermarkFrame.image,
        Rect.fromLTWH(
            0, 0, watermarkWidth.toDouble(), watermarkHeight.toDouble()),
        watermarkRect,
        paint);

    // Convert the result to an image
    final ui.Image finalImage =
        await recorder.endRecording().toImage(originalWidth, originalHeight);

    // Convert the image to bytes (Uint8List)
    ByteData? byteData =
        await finalImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }

    return null;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
