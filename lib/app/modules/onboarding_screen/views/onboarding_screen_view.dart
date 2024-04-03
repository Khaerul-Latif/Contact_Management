import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  OnboardingScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "${controller.getStorage.getBool('hasBoard').then((value) => print("ini adalah value dari  hasBoard $value"))}");
    Get.put(OnboardingScreenController());
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller.controllerPage,
            itemCount: controller.listOnboarding.length,
            onPageChanged: (int index) {
              controller.currentIndex.value = index;
            },
            itemBuilder: (_, index) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.only(
                    top: 40,
                    right: 20,
                    left: 20,
                    bottom: 30,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 315,
                        width: 315,
                        child: Image.asset(
                          controller.listOnboarding[index].image,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        controller.listOnboarding[index].title,
                        style: TextStyle(
                          color: AppColors.kcPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.listOnboarding[index].description,
                        style: TextStyle(color: AppColors.kcTextDescription),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.listOnboarding.length,
                (index) => buildPage(index, context),
              ),
            )),
        Obx(() => Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 35, bottom: 24, left: 20, right: 20),
              child: controller.currentIndex.value ==
                      controller.listOnboarding.length - 1
                  ? CustomElevatedButton(
                      icon: false,
                      text: "Get Started",
                      onPressed: () {
                        controller.getStorage.setBool("hasBoard", true);
                        Get.offAllNamed(Routes.SIGNIN_SCREEN);
                      })
                  : Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              controller.getStorage.setBool("hasBoard", true);
                              Get.offAllNamed(Routes.SIGNIN_SCREEN);
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: AppColors.kcPrimary,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: CustomElevatedButton(
                            icon: false,
                            text: 'Next',
                            onPressed: () {
                              // ;                          print("Banyaknya List: ${controller.listOnboarding.length--}");
                              print(controller.currentIndex.value);
                              controller.controllerPage.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            )),
      ],
    ));
  }

  Container buildPage(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.currentIndex.value == index
            ? AppColors.kcPrimary
            : AppColors.kcGreyPrimary,
      ),
    );
  }
}
