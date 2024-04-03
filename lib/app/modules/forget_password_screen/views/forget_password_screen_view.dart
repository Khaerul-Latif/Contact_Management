import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forget_password_screen_controller.dart';

class ForgetPasswordScreenView extends GetView<ForgetPasswordScreenController> {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBarAuthText(text: "Forget Password"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomComponenAuthText(
                text: "Forget Password",
              ),
              SizedBox(height: 5),
              CustomComponenAuthText(
                text: "Enter your email address and we will",
                fontWeight: FontWeight.normal,
                fontSize: 12,
                colorText: AppColors.kcHeadingDua,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: controller.emailC,
                textLabelnHint: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),
              Obx(() => CustomElevatedButton(
                    text: 'Confirm',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        authController.resetPassword(controller.emailC.text,
                            context, controller.isLoading);
                        controller.onClear();
                      }
                    },
                    isLoading: controller.isLoading.value,
                    icon: false, 
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
