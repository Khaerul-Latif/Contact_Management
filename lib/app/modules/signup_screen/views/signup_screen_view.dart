import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_screen_controller.dart';

class SignUpScreenView extends GetView<SignUpScreenController> {
  var authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBarAuthText(text: "Sign Up"),
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
                  text: "Create Account",
                ),
                SizedBox(height: 5),
                CustomComponenAuthText(
                  text: "Enter Your Full name and Email for ",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  colorText: AppColors.kcHeadingDua,
                ),
                CustomComponenAuthText(
                  text: "for sign Up",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  colorText: AppColors.kcHeadingDua,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.fullC,
                  textLabelnHint: 'Full Name',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
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
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
                          .hasMatch(value)) {
                        return "Password must contain letters and numbers";
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
                Obx(
                  () => CustomTextFieldPassword(
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return "Confirm Password is required";
                      } else if (value.length < 6) {
                        return "Confirm Password must be at least 6 characters";
                      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
                          .hasMatch(value)) {
                        return "Confirm Password must contain letters and numbers";
                      } else if (value != controller.passC.text) {
                        return 'Confirm Password must match the Password';
                      }
                    },
                    confirm: controller.passC.text,
                    controller: controller.passConC,
                    textLabelnHint: 'Confirm Password',
                    textInputType: TextInputType.visiblePassword,
                    onPressed: () {
                      controller.toggleConPasswordVisibility();
                    },
                    obPass: controller.obConPass.value,
                  ),
                ),
                SizedBox(height: 15),
                CustomElevatedButton(
                      text: 'Sign Up',
                      onPressed: () async {
                        final formKey = controller.formKey.currentState!;
                        String fullName = controller.fullC.text;
                        String email = controller.emailC.text;
                        String password = controller.passC.text;

                        // User updatedUser = authController.auth.currentUser!;
                        if (formKey.validate()) {
                          // Get.toNamed(Routes.SIGNIN_SCREEN);
                          await authController.signUp(email!, password!, fullName!,
                              context, controller.isLoading.value);
                          // if (e == "Null check operator used on a null value") {
                          //   if (updatedUser.email == email) {
                          //       CustomAlertDialog(
                          //         context: context,
                          //         onPressedYes: () {
                          //           Get.back();
                          //         },
                          //         titleAlertDialog: "Email Already Registered",
                          //         subtitleAlertDialog:
                          //             "The email address you provided is already associated with an existing account. Please use a different email address or sign in with your existing account.",
                          //         textActionYes: 'OK',
                          //         doubleAction: false,
                          //         heightContainer: 180);
                          //     return;
                          //   }

                          //   // Print user details for verification
                          //   print("User UID: ${updatedUser.uid}");
                          //   print("Full Name: ${updatedUser.displayName}");
                          //   print("Email: ${updatedUser.email}");
                          //   print("Email Verified: ${updatedUser.emailVerified}");
                          //   print("User : ");
                          // }
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomComponenAuthText(
                          text: "Already have account?",
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          colorText: AppColors.kcHeadingDua,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CustomComponenAuthText(
                            text: "Sign In",
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
                    CustomComponenAuthText(
                      text: "By Signing up you agree to our Terms",
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      colorText: AppColors.kcHeadingDua,
                    ),
                    CustomComponenAuthText(
                      text: "Conditions & Privacy Policy.",
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      colorText: AppColors.kcHeadingDua,
                    ),
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
                    Obx(
                      () => CustomElevatedButton(
                        text: 'connect with google',
                        buttonColor: AppColors.kcSecondary,
                        onPressed: () async {
                          print(
                              "isLoading Google 1: ${controller.isLoadingGoogle.value}");

                          // UserCredential? userCredential = await authController.signInWithGoogle(controller.isLoadingGoogle);
                          await authController
                              .signInWithGoogle(controller.isLoadingGoogle);

                          /*if(userCredential != null) {
                             String uid = userCredential.user?.uid ?? "";
                            String email = userCredential.user?.email ?? "";
                            String emailVerification = userCredential
                                    .user?.emailVerified
                                    .toString() ??
                                "";
                            print("User ID : ");
                            print("User Email : ");
                            print("User EmailVerfikasi : ");

                           }*/
                          print(
                              "isLoading Google 2: ${controller.isLoadingGoogle.value}");
                        },
                        isLoading: controller.isLoadingGoogle.value,
                        icon: true,
                      ),
                    ),
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
