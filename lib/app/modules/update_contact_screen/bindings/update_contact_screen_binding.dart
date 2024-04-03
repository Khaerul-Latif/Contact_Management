import 'package:get/get.dart';

import '../controllers/update_contact_screen_controller.dart';

class UpdateContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateContactScreenController>(
      () => UpdateContactScreenController(),
    );
  }
}
