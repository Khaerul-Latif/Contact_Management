import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchContactScreenController extends GetxController {
  //TODO: Implement SearchContactScreenController
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
