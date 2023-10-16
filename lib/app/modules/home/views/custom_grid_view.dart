import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:movie_review/app/widgets/row_spacer.dart';

import '../../../data/models/spiderman_search_model.dart' as model;
import '../../../helper/app_assets.dart';
import '../../../helper/colors.dart';
import '../../../helper/responsive_ui.dart';
import '../../../widgets/ColumnSpacer.dart';
import '../../../widgets/custom_text.dart';

class CustomGridView extends GetView {
  const CustomGridView({
    Key? key,
    //required this.child,
    required this.count,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.maxCrossAxisExtent,
    required this.items,
    required this.onGridItemTap,
    this.showBanner = false,
  }) : super(key: key);

  //final Widget child;
  final int count;
  final double childAspectRatio;
  final double maxCrossAxisExtent;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final List<model.SpiderManSearch> items;
  final Function onGridItemTap;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: GridView.builder(
        // padding: EdgeInsets.fromLTRB(
        //     0, ResponsiveUI().height(1), 0, ResponsiveUI().height(1)),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: childAspectRatio, //2 / 2,
          crossAxisSpacing: crossAxisSpacing, // 10,
          mainAxisSpacing: mainAxisSpacing, //10,),
        ),
        itemCount: count,
        itemBuilder: (BuildContext ctx, index) {
          return Obx(
            () => _gridRowView(index, ctx),
          );
        },
      ),
    );
  }

  bool checkBannerStatus(int index) {
    bool showBanner = false;
    // var item = serviceTypeList[index];
    // showBanner = item.disabled ?? true;
    showBanner = false;
    return showBanner;
  }

  _gridRowView(int index, BuildContext ctx) {
    return InkWell(
      onTap: () {
        onGridItemTap(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.fromLTRB(1, 1, 1, 1),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            padding: EdgeInsets.only(
                left: ResponsiveUI().width(1.5),
                top: ResponsiveUI().width(1.5),
                right: ResponsiveUI().width(1.5),
                bottom: ResponsiveUI().width(1.5)),
            child: _imageView(index),
          ),
          ColumnSpacer(value: ResponsiveUI().width(0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CustomText(
                  text: items[index].show!.name ?? "",
                  color: AppColors.textColor,
                  fontSize: ResponsiveUI().fontSize(7),
                  maxLines: 2,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const RowSpacer(value: 2),
              CustomText(
                text: _getYear(items[index].show!.premiered) != null
                    ? "(${_getYear(items[index].show!.premiered)})"
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
        ],
      ),
    );
  }

  Widget _imageView(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        "${items[index].show!.image!.medium}",
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            AppAssets.noImage,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  _getYear(DateTime? date) {
    if (date != null) {
      DateFormat dateFormat = DateFormat("yyyy");
      return dateFormat.format(date);
    }
    // return year;
  }
}
