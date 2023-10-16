import 'enums/app_enums.dart';

class AppConfig {
  static String CURRENT_VERSION = "0.0.1";
  static int CURRENT_VERSION_CODE = 01;

  // ToDo: while releasing, change mode to [prod]
  static Environment MODE = Environment.dev;
}
