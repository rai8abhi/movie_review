import 'config.dart';
import 'enums/app_enums.dart';
import 'network_helper.dart';

class NetworkConfig {
  static const String SERVER_BASE_URL_DEV = "https://api.tvmaze.com";

  static const String SERVER_BASE_URL_LIVE = "https://api.abhi.in/api";

  static String get URL => BASE_URL();
  static NetworkHelper _networkHelper = NetworkHelper();

  static NetworkHelper networkHelper() {
    return _networkHelper;
  }

  static String BASE_URL() {
    switch (AppConfig.MODE) {
      case Environment.prod:
        return SERVER_BASE_URL_LIVE;
      case Environment.dev:
        return SERVER_BASE_URL_DEV;
    }
  }
}
