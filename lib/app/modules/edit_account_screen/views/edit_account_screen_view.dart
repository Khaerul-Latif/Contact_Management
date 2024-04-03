import 'dart:io';

import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_account_screen_controller.dart';

class EditAccountScreenView extends GetView<EditAccountScreenController> {
  EditAccountScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditAccountScreenController());
    Map<String, dynamic> getData = Get.arguments;
    String? fullName = getData['fullname'];
    String email = getData['email'];
    String? imageUrl = getData['image'];
    controller.fullNameC.text = fullName ?? '';
    controller.emailC.text = email;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          'Edit Account',
          style: TextStyle(
              color: AppColors.kcBlackPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Obx(() {
                    final String? imagePath = controller.imagePath.value;
                    final String? displayImageUrl =
                        (imagePath != '') ? imagePath : imageUrl;
                    return displayImageUrl! != ''
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                backgroundImage: ImageType(displayImageUrl),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.kcBgPhotoContact,
                              ),
                              child: Center(
                                child: Text(
                                  controller.fullNameC.text[0],
                                  style: TextStyle(
                                    color: AppColors.kcBackgroundColor,
                                    fontSize: 64,
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          CustomAlertDialogContact(
                            heightContainer: 180,
                            context: context,
                            onPressedGallery: () {
                              controller.pickImageGallery();
                            },
                            titleAlertDialog: 'Select Image Source',
                            subtitleAlertDialog:
                                'Choose the source of the Image',
                            textActionGallery: 'Gallery',
                            textActionCamera: 'Camera',
                            onPressedCamera: () {
                              controller.pickImageCamera();
                            },
                          );
                        },
                        child: Image.asset('assets/icons/edit.png',
                            width: 28, height: 28),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomTextFormFieldNoBorder(
                  controller: controller.fullNameC,
                  textInputType: TextInputType.name,
                  textLabelnHint: "Full Name"),
              SizedBox(height: 30),
              CustomTextFormFieldNoBorder(
                  controller: controller.emailC,
                  textInputType: TextInputType.emailAddress,
                  textLabelnHint: "Email"),
              SizedBox(height: 30),
              CustomElevatedButton(
                text: 'Save',
                onPressed: () {
                  final String? imagePath = controller.imagePath.value;
                  final String? displayImageUrl =
                      (imagePath != '') ? imagePath : imageUrl;
                  final formKey = controller.formKey.currentState!;
                  final file = File(displayImageUrl!);
                  final String fullName = controller.fullNameC.text ?? "";
                  final String email = controller.emailC.text ?? "";
                  // if (imagePath != null) {
                  //   file = File(controller.imagePath.value);
                  // } else {
                  //   file = File(imageUrl!);
                  // }
                  // print('Sebelum Masuk ke action ${controller.isLoading}');

                  if (formKey.validate()) {
                    // print("FileBoss ${file.toString()}");
                    // print('Edit Account controller.isLoading');
                    controller.updateAccount(fullName,
                        email, context, file);
                    // print('Sesudah Masuk ke action ${controller.isLoading}');
                  }
                },
                icon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
