import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreenController extends GetxController {
  //TODO: Implement ForgetPasswordScreenController
  late TextEditingController emailC;
  late GlobalKey<FormState> formKey;
  RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void onClear() => emailC.clear();

  // void increment() => count.value++;
}
