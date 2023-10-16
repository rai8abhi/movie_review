import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/spiderman_search_model.dart';

class DetailScreenController extends GetxController {
  Rx<Show> detailInfo = Show().obs;
  @override
  onInit() {
    _initArgument();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _initArgument() async {
    if (Get.arguments != null) {
      var itemArg = Get.arguments;
      if (itemArg.containsKey('show')) {
        detailInfo.value = itemArg['show'];
      }
    }
  }

  getDate(DateTime? date) {
    if (date != null) {
      DateFormat dateFormat = DateFormat("dd");
      return dateFormat.format(date);
    }
  }

  getMonth(DateTime? date) {
    String month = "";
    if (date != null) {
      DateFormat dateFormat = DateFormat("MM");
      month = dateFormat.format(date);
    }
    switch (month) {
      case "01":
        return "Jan";
      case "02":
        return "Feb";
      case "03":
        return "March";
      case "04":
        return "April";
      case "05":
        return "May";
      case "06":
        return "Jun";
      case "07":
        return "July";
      case "08":
        return "Aug";
      case "09":
        return "Sept";
      case "10":
        return "Oct";
      case "11":
        return "Nov";
      case "12":
        return "Dec";
      default:
        return "";
    }
  }

  getYear(DateTime? date) {
    if (date != null) {
      DateFormat dateFormat = DateFormat("yyyy");
      return dateFormat.format(date);
    }
    // return year;
  }
}
