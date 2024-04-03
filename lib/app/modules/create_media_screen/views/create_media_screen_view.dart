import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

import '../controllers/create_media_screen_controller.dart';

class CreateMediaScreenView extends GetView<CreateMediaScreenController> {
  const CreateMediaScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CreateMediaScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          'Create Media',
          style: TextStyle(
              color: AppColors.kcBlackPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: controller.titleC,
                  textLabelnHint: 'Title',
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller.descriptionC,
                  textLabelnHint: 'Description',
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    controller.pickMedia();
                  },
                  child: DottedBorder(
                    radius: Radius.circular(10),
                    color: Colors.black,
                    strokeWidth: 1.5,
                    dashPattern: [
                      5,
                      5,
                    ],
                    child: Obx(() {
                      // print(
                      //     "media : ${controller.videoPlayerController.value.isInitialized}");
                      return controller.mediaPath.value == ""
                          ? Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/upload.png',
                                  height: 163,
                                  width: 163,
                                ),
                              ),
                            )
                          : controller.mediaPath.value.endsWith('.mp4')
                              ? Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: VideoPlayer(
                                        controller.videoPlayerController),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.file(
                                    File(controller.mediaPath.value),
                                    fit: BoxFit.fitWidth,
                                  ),
                                );

                      // : Container(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Image.file(
                      //       fit: BoxFit.fitWidth,
                      //       File(controller.mediaPath.value),
                      //     ),
                      //   );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                    text: 'Save',
                    onPressed: () {
                      final formKey = controller.formKey.currentState!;
                      final authController = Get.find<AuthController>();
                      final uid = authController.auth.currentUser!.uid;
                      final user = authController.auth.currentUser!;
                      final title = controller.titleC.text;
                      final description = controller.descriptionC.text;
                      File media = File(controller.mediaPath.value);
                      if (formKey.validate()) {
                        controller.createMedia(
                            uid, title, description, media, user, context);
                      }
                    },
                    icon: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
