import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreenController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late GlobalKey<FormState> formKey;

  RxBool isLoadingGoogle = false.obs;
  RxBool isLoading = false.obs;

  var obPass = true.obs;

  void togglePasswordVisibility() {
    obPass.toggle();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailC = TextEditingController();
    passC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
