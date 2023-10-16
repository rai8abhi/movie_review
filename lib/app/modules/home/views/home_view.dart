import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/colors.dart';
import '../../../helper/responsive_ui.dart';
import '../../../widgets/custom_text.dart';
import '../controllers/home_controller.dart';
import 'custom_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        backgroundColor: AppColors.primaryColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Column(
            children: [
              CustomText(
                text: "Find Movies, TV series, and More..",
                color: AppColors.textColor,
                fontSize: ResponsiveUI().fontSize(14),
                maxLines: 2,
                letterSpacing: 1,
                fontWeight: FontWeight.normal,
              ),
              Divider(
                thickness: ResponsiveUI().height(1),
                indent: ResponsiveUI().width(1),
                endIndent: ResponsiveUI().width(88),
                color: Colors.red,
              )
            ],
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          toolbarHeight: ResponsiveUI().height(14),
          iconTheme: const IconThemeData(color: AppColors.textColor),
          titleSpacing: ResponsiveUI().width(2),
        ),
        body: SafeArea(child: _homebody()),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  _homebody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: _viewByCategory(),
      ),
    );
  }

  _viewByCategory() {
    return Obx(
      () => controller.movieList != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomGridView(
                      count: controller.movieList.length,
                      childAspectRatio: 0.59,
                      crossAxisSpacing: ResponsiveUI().height(2),
                      mainAxisSpacing: ResponsiveUI().height(2),
                      maxCrossAxisExtent: ResponsiveUI().height(0),
                      showBanner: false,
                      items: controller.movieList,
                      onGridItemTap: (index) {
                        controller.onGridItemTap(index);
                        print("this is what we want ${index}");
                      }),
                ],
              ),
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

  _bottomNavigation() {
    return SizedBox(
      height: ResponsiveUI().height(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: const Icon(Icons.home),
                iconSize: 30,
                color: AppColors.grey,
                splashColor: AppColors.splashColor,
                onPressed: () {
                  Get.toNamed('/home');
                  Get.offAll(const HomeView());
                }),
            IconButton(
                icon: const Icon(Icons.play_circle),
                iconSize: 30,
                color: AppColors.grey,
                splashColor: AppColors.splashColor,
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.person),
                iconSize: 30,
                color: AppColors.grey,
                splashColor: AppColors.splashColor,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
