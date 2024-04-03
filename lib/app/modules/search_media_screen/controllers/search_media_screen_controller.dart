import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchMediaScreenController extends GetxController {
  //TODO: Implement SearchMediaScreenController
  late TextEditingController searchC;
  final count = 0.obs;
  @override
  void onInit() {
        searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
     searchC.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
