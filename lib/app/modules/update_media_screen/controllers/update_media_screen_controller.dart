import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateMediaScreenController extends GetxController {
   //TODO: Implement CreateContactScreenController
  late TextEditingController titleC;
  late TextEditingController descriptionC;
   late GlobalKey<FormState> formKey;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    titleC = TextEditingController();
    descriptionC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // titleC.dispose();
    // descriptionC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
