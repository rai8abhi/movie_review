import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_review/app/helper/colors.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      color: AppColors.primaryColor,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
