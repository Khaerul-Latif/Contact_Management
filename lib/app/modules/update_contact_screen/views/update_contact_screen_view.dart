import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_contact_screen_controller.dart';

class UpdateContactScreenView extends GetView<UpdateContactScreenController> {
  UpdateContactScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getData = Get.arguments;
    String uid = getData['uid'];
    String docsId = getData['docsId'];
    String? docsImage = getData['docsImage'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          'Update Contact',
          style: TextStyle(
              color: AppColors.kcBlackPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: controller.getDocsId(docsId, uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kcPrimary),
            );
          }
          var itemContact = snapshot.data!.data() as Map<String, dynamic>;
          controller.nameC.text = itemContact['name'];
          controller.numberC.text = itemContact['number'];

          return SingleChildScrollView(
            controller: ScrollController(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: controller.nameC,
                      textLabelnHint: 'Name',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      controller: controller.numberC,
                      textLabelnHint: 'Number',
                      textInputType: TextInputType.phone,
                      maxLines: 5,
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        CustomAlertDialogContact(
                          heightContainer: 180,
                          context: context,
                          onPressedGallery: () {
                            controller.pickImageGallery();
                          },
                          titleAlertDialog: 'Select Image Source',
                          subtitleAlertDialog: 'Choose the source of the Image',
                          textActionGallery: 'Gallery',
                          textActionCamera: 'Camera',
                          onPressedCamera: () {
                            controller.pickImageCamera();
                          },
                        );
                      },
                      child: DottedBorder(
                        radius: Radius.circular(10),
                        color: Colors.black,
                        strokeWidth: 1.5,
                        dashPattern: [
                          5,
                          5,
                        ],
                        child: docsImage != null && docsImage.isNotEmpty
                            ? Obx(() {
                                return controller.imagePath.value != ''
                                    ? Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ImageContact(
                                            controller.imagePath.value))
                                    : Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ImageContact(docsImage!));
                              })
                            : Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/upload.png',
                                    height: 163,
                                    width: 163,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                        text: 'Save',
                        onPressed: () {
                          final formKey = controller.formKey.currentState!;
                          final name = controller.nameC.text;
                          final number = controller.numberC.text;
                          final createdAt = itemContact['created-at'];
                          String imageUrl = controller.imagePath.value != ''
                              ? controller.imagePath.value
                              : docsImage!;

                          print("docsImage : $docsImage");
                          if (formKey.validate()) {
                            controller.updateContact(name, number, imageUrl,
                                createdAt, docsId, uid, context);
                          }
                        },
                        icon: false),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
