import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signin_screen_controller.dart';

class SignInScreenView extends GetView<SignInScreenController> {
  SignInScreenView({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBarAuthText(text: "Sign In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomComponenAuthText(
                  text: "Welcome",
                ),
                SizedBox(height: 5),
                CustomComponenAuthText(
                  text: "Enter Your or Email and Password",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  colorText: AppColors.kcHeadingDua,
                ),
                CustomComponenAuthText(
                  text: "for sign in",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  colorText: AppColors.kcHeadingDua,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.emailC,
                  textLabelnHint: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                Obx(
                  () => CustomTextFieldPassword(
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return "Password is required";
                      } else {
                        return null;
                      }
                    },
                    controller: controller.passC,
                    textLabelnHint: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () {
                      controller.togglePasswordVisibility();
                    },
                    obPass: controller.obPass.value,
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomAuthTextButton(
                    text: 'Forget Password',
                    onPressed: () {
                      Get.toNamed(Routes.FORGET_PASSWORD_SCREEN);
                    },
                  ),
                ),
                SizedBox(height: 15),
                CustomElevatedButton(
                  text: 'Sign In',
                  onPressed: () async {
                    final formKey = controller.formKey.currentState!;
                    if (formKey.validate()) {
                      await authController.signIn(controller.emailC.text,
                          controller.passC.text, context, controller.isLoading);
                    }
                  },
                  isLoading: controller.isLoading.value,
                  icon: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomComponenAuthText(
                      text: "Or",
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      colorText: AppColors.kcHeadingDua,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomComponenAuthText(
                          text: "Don’t have account?",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          colorText: AppColors.kcHeadingDua,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SIGNUP_SCREEN);
                          },
                          child: CustomComponenAuthText(
                            text: "Create new account",
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            colorText: AppColors.kcSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => CustomElevatedButton(
                          text: 'connect with google',
                          buttonColor: AppColors.kcSecondary,
                          onPressed: () async {
                            print(
                                "isLoading Google 1: ${controller.isLoadingGoogle.value}");

                            await authController
                                .signInWithGoogle(controller.isLoadingGoogle);

                            print(
                                "isLoading Google 2: ${controller.isLoadingGoogle.value}");
                          },
                          isLoading: controller.isLoadingGoogle.value,
                          icon: true,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
