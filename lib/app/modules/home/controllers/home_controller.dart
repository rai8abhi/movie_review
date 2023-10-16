import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/api/movie_api.dart';
import '../../../data/models/spiderman_search_model.dart';
import '../../../helper/response_helper.dart';
import '../../../utils/app_dialogs.dart';

class HomeController extends GetxController {
  final RxList<SpiderManSearch> movieList = <SpiderManSearch>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await readHomePageList();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> readHomePageList() async {
    var list = await readMovieListFromApi();
    if (list != null && list.isNotEmpty) {
      var movieResponse = list;
      if (movieResponse != null && movieResponse.isNotEmpty) {
        for (var element in movieResponse) {
          movieList.add(element);
        }
      }
    }
  }

  static Future<List<SpiderManSearch>> readMovieListFromApi() async {
    ResponseData responseData = await MovieApi.getMovie(
      onTry: () {},
      showLoading: false,
    );
    List<SpiderManSearch> movieList = [];
    if (responseData.error!.isNotEmpty) {
      AppDialogs.showDialogActionError(Get.context, LocaleKeys.errors_error.tr,
          responseData.error!, LocaleKeys.general_close.tr, true, () {});
    } else {
      if (responseData.response != null) {
        movieList = spiderManSearchFromJson(responseData.response!);
      }
    }
    return movieList;
  }

  onGridItemTap(int index) async {
    if (movieList[index].show != null) {
      Get.toNamed("/detail-screen", arguments: {
        // arg['flowData'] = flowData;
        "show": movieList[index].show,
      });
    }
  }
}
