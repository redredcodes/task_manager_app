import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/network_response.dart';
import 'package:http/http.dart';

// the get request
class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  // the post request
  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
        'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}');
  }
}