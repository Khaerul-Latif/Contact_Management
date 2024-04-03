import 'package:dotted_border/dotted_border.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_media_screen_controller.dart';

class UpdateMediaScreenView extends GetView<UpdateMediaScreenController> {
  const UpdateMediaScreenView({Key? key}) : super(key: key);
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
      body: Container(
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
                onTap: () {},
                child: DottedBorder(
                  radius: Radius.circular(10),
                  color: Colors.black,
                  strokeWidth: 1.5,
                  dashPattern: [
                    5,
                    5,
                  ],
                  child: Container(
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
                    if (formKey.validate()) {}
                  },
                  icon: false),
            ],
          ),
        ),
      ),
    );
  }
}
