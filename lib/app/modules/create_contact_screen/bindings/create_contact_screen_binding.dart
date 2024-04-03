import 'package:get/get.dart';

import '../controllers/create_contact_screen_controller.dart';

class CreateContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateContactScreenController>(
      () => CreateContactScreenController(),
    );
  }
}
