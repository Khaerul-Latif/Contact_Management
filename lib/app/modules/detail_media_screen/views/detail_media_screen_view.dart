import 'package:flubase_mobile/app/modules/update_media_screen/views/update_media_screen_view.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simulate/simulate_core.dart';

import '../controllers/detail_media_screen_controller.dart';

class DetailMediaScreenView extends GetView<DetailMediaScreenController> {
  const DetailMediaScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 20),
          child: CustomAppBarAuthText(
              text: 'dsadasdasdasdasd',
              colorText: AppColors.kcBlackPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        foregroundColor: AppColors.kcBlackPrimary,
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              CustomShowBottomDialog(
                context: context,
                onPressedUpdate: () {
                  Get.toNamed(Routes.UPDATE_MEDIA_SCREEN);
                },
                onPressedDelete: () {
                  Get.back();
                  CustomAlertDialog(
                    doubleAction: true,
                    context: context,
                    onPressedYes: () {
                      Get.back();
                    },
                    onPressedNo: () {
                      Get.back();
                    },
                    titleAlertDialog: '',
                    subtitleAlertDialog: '',
                    textActionYes: '',
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Image.asset(
                color: AppColors.kcBlackPrimary,
                'assets/icons/more.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/dummy_media1.png',
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.kcDescription,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
