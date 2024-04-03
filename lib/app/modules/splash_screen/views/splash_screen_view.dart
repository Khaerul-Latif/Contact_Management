import 'dart:async';

import 'package:flubase_mobile/app/modules/onboarding_screen/views/onboarding_screen_view.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    Timer(Duration(seconds: 1), () {
      controller.checkLogin();
    });

    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }
}
