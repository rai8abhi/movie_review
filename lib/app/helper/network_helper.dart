import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'easy_loading_helper.dart';

class NetworkHelper {
  static Future<Map<String, String>> prepareCommonHeaders() async {
    Map<String, String> requestHeaders = {};
    return requestHeaders;
  }

  Future<dynamic> get({
    required String url,
    required dynamic headers,
    dynamic body,
    required bool loading,
    required bool alert,
    required bool success,
    int? timeout,
    Function? onTryAgain,
    bool? login = false,
  }) async {
    var responseJson;
    try {
      if (loading) {
        EasyLoadingHelper.easyLoading();
      }

      var header = await prepareCommonHeaders();
      Map<String, String> requestHeaders = {};
      requestHeaders.addAll(header);
      if (headers != null) {
        requestHeaders.addAll(headers);
      }
      if (login != null && login) {
        requestHeaders.remove('flowId');
      }
      var uri = Uri.parse(url);
      Uri? uri1;
      if (body != null) {
        uri1 = uri.replace(queryParameters: body);
      } else {
        uri1 = uri;
      }
      final http.Response response = await http
          .get(
            uri1,
            headers: requestHeaders,
          )
          // .timeout(Duration(minutes: 3) );
          .timeout(timeout == null
              ? Duration(minutes: 3)
              : Duration(seconds: timeout));

      responseJson = response;
    } on SocketException catch (e, s) {
      //ToDo: show internet connection as toast
      EasyLoading.showError('No Internet connection');
    } on TimeoutException catch (_) {
      if (loading) EasyLoadingHelper.hideLoader();
    } on Exception catch (e, s) {
      print('Exception Exception info: ${e}');
      print('Exception Stack Trace: ${s}');
    } finally {
      if (loading) EasyLoadingHelper.hideLoader();
    }

    return responseJson;
  }
}
