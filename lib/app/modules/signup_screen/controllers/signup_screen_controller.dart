import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController fullC;
  late TextEditingController passConC;
  late GlobalKey<FormState> formKey;

  RxBool isLoading = false.obs;
  RxBool isLoadingGoogle = false.obs;

  void startLoading() {
    isLoadingGoogle.value = true;
  }

  void stopLoading() {
    isLoadingGoogle.value = false;
  }

  var obPass = true.obs;
  var obConPass = true.obs;

  void togglePasswordVisibility() {
    obPass.toggle();
  }

  void toggleConPasswordVisibility() {
    obConPass.toggle();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passC = TextEditingController();
    fullC = TextEditingController();
    passConC = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    fullC.dispose();
    passConC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
