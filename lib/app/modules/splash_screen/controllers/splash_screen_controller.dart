import 'package:flubase_mobile/app/modules/onboarding_screen/views/onboarding_screen_view.dart';
import 'package:flubase_mobile/app/modules/signin_screen/views/signin_screen_view.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/index_screen.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  LocalStorage getStorage = LocalStorage();

  void checkLogin() async {
    Future<bool> isLogin = getStorage.getBool("isLogin");
    isLogin.whenComplete(() async {
      await isLogin.then(
        (value) async {
          if (!value) {
            var hasBoard = getStorage.getBool('hasBoard');
            await hasBoard.whenComplete(() async {
              await hasBoard.then((value) {
                if (value) {
                  Get.offAllNamed(Routes.SIGNIN_SCREEN);
                } else {
                  Get.offAllNamed(Routes.ONBOARDING_SCREEN);
                }
              });
            });
          } else {
            Get.offAllNamed(Routes.INDEX_SCREEN);
          }
        },
      );
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
}
