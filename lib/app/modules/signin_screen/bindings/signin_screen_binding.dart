import 'package:get/get.dart';

import '../controllers/signin_screen_controller.dart';

class SignInScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInScreenController>(
      () => SignInScreenController(),
    );
  }
}
