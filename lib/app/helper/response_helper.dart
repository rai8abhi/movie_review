import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/error.dart';
import 'easy_loading_helper.dart';

class ResponseData {
  final String? response;
  final String? error;
  final int? statusCode;

  ResponseData({this.response, this.statusCode, this.error});

  @override
  String toString() {
    return "ResponseData {response: $response, statusCode: $statusCode, error: $error}";
  }
}

class ResponseHelper {
  static ResponseData handleResponse(
      http.Response? response, Exception? exception) {
    // ResponseData userDetailsResponse = ResponseData();
    if (exception != null || response == null) {
      return ResponseData(
        error: 'Failed to process your request.',
        statusCode: 0,
        response: '',
      );
    }
    if (response != null &&
        response.statusCode != null &&
        response.statusCode == 403) {
      return ResponseData(
        error:
            'Your session has expired. Please Log-in with username/password.',
        statusCode: response.statusCode,
        response: '',
      );
    }
    if (response != null) {
      int statusCode = 0;
      String responseBody = '';
      String errorstr = '';
      try {
        statusCode = response.statusCode;
        if (statusCode == 200) {
          // Logger.print('ResponseHelper success: ' + utf8.decode(response.bodyBytes));
          // Logger.print('ResponseHelper success: ' + response.body);
          responseBody = utf8.decode(response.bodyBytes);
        } else {
          print('ResponseHelper failure: ' + utf8.decode(response.bodyBytes));
          ErrorModel error =
              ErrorModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
          print('ResponseHelper failure error: $error');

          if (statusCode >= 400 && statusCode < 500) {
            print('ResponseHelper failure error in 1: $error');
            // errorstr = error.message!;
            if (error.message != null) {
              String debugMessage = "";
              if (error.debugMessage != null)
                debugMessage = " - ${error.debugMessage}";
              errorstr = "${error.message}" + debugMessage;
            } else if (error.error != null) {
              String error_description = "";
              if (error.error_description != null)
                error_description = " - ${error.error_description}";
              errorstr = "${error.error}" + error_description;
            } else {
              errorstr = error.message ?? "Unknown error";
            }
          } else {
            print('ResponseHelper failure error else: $error');
            if (error.message != null) {
              String debugMessage = "";
              if (error.debugMessage != null)
                debugMessage = " - ${error.debugMessage}";
              errorstr = "${error.message}" + debugMessage;
            } else if (error.error != null) {
              String error_description = "";
              if (error.error_description != null)
                error_description = " - ${error.error_description}";
              errorstr = "${error.error}" + error_description;
            } else {
              errorstr = error.message ?? "Unknown error";
            }
          }
        }
      } catch (e) {
        ///need to test by hiding loader
        EasyLoadingHelper.hideLoader();
        print(
          'handleResponse Error Parsing:' + e.toString(),
        );
        errorstr = '${e.toString()}';
      }
      return ResponseData(
        error: errorstr,
        statusCode: statusCode,
        response: responseBody,
      );
    } else {
      return ResponseData(
        error: 'Failed to process your request.',
        statusCode: 0,
        response: '',
      );
    }
  }
}
