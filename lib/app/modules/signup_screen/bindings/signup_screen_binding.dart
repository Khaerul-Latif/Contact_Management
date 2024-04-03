import 'package:get/get.dart';

import '../controllers/signup_screen_controller.dart';

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpScreenController>(
      () => SignUpScreenController(),
    );
  }
}
