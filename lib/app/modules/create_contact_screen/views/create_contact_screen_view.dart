import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_contact_screen_controller.dart';

class CreateContactScreenView extends GetView<CreateContactScreenController> {
  CreateContactScreenView({Key? key}) : super(key: key);
  // final CreateContactScreenController controller =
  //     Get.put(CreateContactScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.start,
          'Create Contact',
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
                  controller: controller.nameC,
                  textLabelnHint: 'Name',
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller.numberC,
                  textLabelnHint: 'Number',
                  textInputType: TextInputType.phone,
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
                    dashPattern: [5, 5],
                    child: Obx(() {
                      return controller.imagePath.value.isEmpty
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
                          : Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.file(
                                fit: BoxFit.fitWidth,
                                File(controller.imagePath.value),
                              ),);
                    }),
                  ),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Save',
                  onPressed: () {
                    var formKey = controller.formKey.currentState!;
                    final authController = Get.find<AuthController>();
                    final uid = authController.auth.currentUser!.uid;
                    final user = authController.auth.currentUser!;
                    final name = controller.nameC.text;
                    final number = controller.numberC.text;
                    File file = File(controller.imagePath.value);
                  
                    // final imageUrl = File(controller.imagePath.value);
                    if (formKey.validate()) {
                      controller.createContact(uid, name, number, file, user, context);           
                    }
                  },
                  icon: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
