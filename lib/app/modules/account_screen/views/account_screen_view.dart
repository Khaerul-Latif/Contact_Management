import 'package:flubase_mobile/app/modules/account_screen/controllers/account_screen_controller.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AccountScreenView extends GetView<AccountScreenController> {
  AccountScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(AccountScreenController());
    print("Full name1 : ${controller.fullName!.value}");
    print("Email1 : ${controller.email!.value}");
    print("Image1 : ${controller.imageUrl!.value}");
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            textAlign: TextAlign.start,
            'Account',
            style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  controller.authController.signOut();
                },
                icon: Icon(
                    color: AppColors.kcBlackPrimary, Icons.logout_outlined)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FutureBuilder<void>(
            future:
                controller.fetchData(), // Call fetchData method asynchronously
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while data is being fetched
                return ShimmerAccount();
              }

              if (snapshot.hasError) {
                // Display an error message if an error occurred
                return Text('Error: ${snapshot.error}');
              }

              // Once the data is available, build the UI
              return Column(
                children: [
                  (controller.imageUrl?.value == null ||
                          controller.imageUrl!.value == "")
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kcBgPhotoContact,
                          ),
                          child: Center(
                            child: (Text(
                              controller.fullName!.value != ""
                                  ? controller.fullName!.value[0]
                                  : "",
                              style: TextStyle(
                                color: AppColors.kcBackgroundColor,
                                fontSize: 64,
                              ),
                            )),
                          ),
                        )
                      : Obx(() => Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kcBgPhotoContact,
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  ImageType(controller.imageUrl!.value),
                            ),
                          )),
                  SizedBox(height: 20),
                  Obx(() => Text(
                        controller.fullName!.value != ""
                            ? controller.fullName!.value
                            : "",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 5),
                  Obx(() => Text(
                        controller.email!.value != ""
                            ? controller.email!.value
                            : "",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'Edit Account',
                    onPressed: () {
                      Get.toNamed(Routes.EDIT_ACCOUNT_SCREEN, arguments: {
                        'fullname': controller.fullName!.value ?? "",
                        'email': controller.email!.value ?? "",
                        'image': controller.imageUrl!.value ?? ""
                      });
                    },
                    icon: false,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
