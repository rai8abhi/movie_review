import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:movie_review/app/widgets/ColumnSpacer.dart';
import 'package:movie_review/app/widgets/row_spacer.dart';

import '../../../helper/app_assets.dart';
import '../../../helper/colors.dart';
import '../../../helper/responsive_ui.dart';
import '../../../widgets/custom_text.dart';
import '../controllers/detail_screen_controller.dart';

class DetailScreenView extends GetView<DetailScreenController> {
  const DetailScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        backgroundColor: AppColors.primaryColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: _homebody()),
      ),
    );
  }

  _homebody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: _detailView(),
      ),
    );
  }

  _detailView() {
    return Obx(
      () => controller.detailInfo.value != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: <Widget>[
                  _imageView(controller.detailInfo.value.image!.original),
                  IconButton(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 40,
                      color: AppColors.textColor,
                      splashColor: AppColors.splashColor,
                      onPressed: () {
                        Get.back();
                      }),
                ]),
                const ColumnSpacer(value: 4),
                Padding(
                  padding: EdgeInsets.only(left: ResponsiveUI().width(2)),
                  child: CustomText(
                    text: controller.detailInfo.value.name != null
                        ? "${controller.detailInfo.value.name}"
                        : "",
                    color: AppColors.textColor,
                    fontSize: ResponsiveUI().fontSize(17),
                    maxLines: 1,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const ColumnSpacer(value: 2),
                Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.watch_later_outlined),
                        iconSize: 20,
                        color: AppColors.textColor,
                        splashColor: AppColors.splashColor,
                        onPressed: () {}),
                    CustomText(
                      text: controller.detailInfo.value.runtime != null
                          ? "${controller.detailInfo.value.runtime} minutes"
                          : "",
                      color: AppColors.grey,
                      fontSize: ResponsiveUI().fontSize(7),
                      maxLines: 2,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const RowSpacer(value: 20),
                    IconButton(
                        icon: const Icon(Icons.star),
                        iconSize: 20,
                        color: AppColors.textColor,
                        splashColor: AppColors.splashColor,
                        onPressed: () {}),
                    CustomText(
                      text: controller.detailInfo.value.rating!.average != null
                          ? "${controller.detailInfo.value.rating!.average} (IMDb)"
                          : "",
                      color: AppColors.grey,
                      fontSize: ResponsiveUI().fontSize(7),
                      maxLines: 2,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const ColumnSpacer(value: 2),
                Divider(
                  thickness: ResponsiveUI().height(0.1),
                  // indent: ResponsiveUI().width(1),
                  // endIndent: ResponsiveUI().width(88),
                  color: AppColors.splashColor,
                ),
                const ColumnSpacer(value: 2),
                _premieredGenreView(),
                const ColumnSpacer(value: 2),
                Divider(
                  thickness: ResponsiveUI().height(0.1),
                  // indent: ResponsiveUI().width(1),
                  // endIndent: ResponsiveUI().width(88),
                  color: AppColors.splashColor,
                ),
                const ColumnSpacer(value: 2),
                _summaryView(),
              ],
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: ResponsiveUI().width(2),
                  right: ResponsiveUI().width(2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: "There is no movie to display",
                    color: AppColors.textColor,
                    fontSize: ResponsiveUI().fontSize(6),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    letterSpacing: 1.4,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
    );
  }

  _imageView(String? image) {
    return SizedBox(
      height: ResponsiveUI().height(30),
      width: ResponsiveUI().width(100),
      child: Image.network(
        "$image",
        fit: BoxFit.fill,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            AppAssets.noImage,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }

  _premieredGenreView() {
    return Padding(
      padding: EdgeInsets.only(left: ResponsiveUI().width(2)),
      child: Column(
        children: [
          _headerPremieredGenreView(),
          const RowSpacer(value: 5),
          _subTextPremieredGenreView()
        ],
      ),
    );
  }

  _headerPremieredGenreView() {
    return Row(
      children: [
        CustomText(
          text: "Premiered",
          color: AppColors.textColor,
          fontSize: ResponsiveUI().fontSize(10),
          maxLines: 2,
          letterSpacing: 1.2,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        const RowSpacer(
          value: 10,
        ),
        CustomText(
          text: "Genre",
          color: AppColors.textColor,
          fontSize: ResponsiveUI().fontSize(10),
          maxLines: 2,
          letterSpacing: 1.2,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  _subTextPremieredGenreView() {
    return Row(
      children: [
        Row(
          children: [
            CustomText(
              text: controller.detailInfo.value.premiered != null
                  ? controller.getMonth(controller.detailInfo.value.premiered)
                  : "",
              color: AppColors.textColor,
              fontSize: ResponsiveUI().fontSize(5),
              maxLines: 2,
              letterSpacing: 1.2,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const RowSpacer(value: 1),
            CustomText(
              text: controller.detailInfo.value.premiered != null
                  ? "${controller.getDate(controller.detailInfo.value.premiered)},"
                  : "",
              color: AppColors.textColor,
              fontSize: ResponsiveUI().fontSize(5),
              maxLines: 2,
              letterSpacing: 1.2,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const RowSpacer(value: 1),
            CustomText(
              text: controller.detailInfo.value.premiered != null
                  ? controller.getYear(controller.detailInfo.value.premiered)
                  : "",
              color: AppColors.textColor,
              fontSize: ResponsiveUI().fontSize(5),
              maxLines: 2,
              letterSpacing: 1.2,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const RowSpacer(value: 16),
        Flexible(
          child: _genreTagListView(),
        ),
      ],
    );
  }

  _genreTagListView() {
    return SizedBox(
      width: ResponsiveUI().width(100),
      height: ResponsiveUI().height(5),
      child: ListView.builder(
        itemExtent: 70.0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.detailInfo.value.genres!.length,
        // itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: ResponsiveUI().height(0.5),
              left: ResponsiveUI().width(1),
              right: ResponsiveUI().width(1),
              bottom: ResponsiveUI().width(0.5),
            ),
            child: _genreTagView(controller.detailInfo.value.genres![index]),
          );
        },
      ),
    );
  }

  _genreTagView(String genres) {
    return Container(
      padding: EdgeInsets.only(
        top: ResponsiveUI().height(0.5),
        left: ResponsiveUI().width(1),
        right: ResponsiveUI().width(1),
        bottom: ResponsiveUI().width(0.5),
      ),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColors.darkWhite,
            blurRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ResponsiveUI().height(3.5)),
          topRight: Radius.circular(ResponsiveUI().height(3.5)),
          bottomLeft: Radius.circular(ResponsiveUI().height(3.5)),
          bottomRight: Radius.circular(ResponsiveUI().height(3.5)),
        ),
      ),
      child: Center(
          child: CustomText(
        text: genres,
        color: AppColors.primaryColor,
        fontSize: ResponsiveUI().fontSize(5),
        maxLines: 1,
        letterSpacing: 1.2,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      )),
    );
  }

  _summaryView() {
    final htmlContent =
        '<b style="color: grey;">${controller.detailInfo.value.summary}</p>';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ResponsiveUI().width(2)),
          child: CustomText(
            text: "Summary",
            color: AppColors.textColor,
            fontSize: ResponsiveUI().fontSize(10),
            maxLines: 1,
            letterSpacing: 1.2,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Html(
          // data: controller.detailInfo.value.summary,
          data: htmlContent,
        ),
      ],
    );
  }
}
