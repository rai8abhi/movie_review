import 'package:http/http.dart' as http;

import '../../helper/network_config.dart';
import '../../helper/network_helper.dart';
import '../../helper/response_helper.dart';

class MovieApi {
  static String URL = NetworkConfig.URL;
  static final NetworkHelper _laNetworkHelper = NetworkConfig.networkHelper();

  static Future<ResponseData> getMovie({
    // required Map data,
    bool alert = true,
    bool showLoading = true,
    required Function onTry,
  }) async {
    http.Response? response;
    Exception? exception;
    try {
      var url = "$URL/search/shows?q=spiderman";
      print('getCategory URL - $url');

      response = await _laNetworkHelper.get(
        url: url,
        // body: data,
        alert: alert,
        loading: showLoading,
        onTryAgain: onTry,
        headers: null,
        success: false,
      );
    } on Exception catch (e) {
      print('get category response error : $e');
      exception = e;
    }
    ResponseData responseData =
        ResponseHelper.handleResponse(response, exception);
    print("response :- ${responseData}");
    return responseData;
  }
}
