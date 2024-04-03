import 'package:get/get.dart';

import '../controllers/edit_account_screen_controller.dart';

class EditAccountScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountScreenController>(
      () => EditAccountScreenController(),
    );
  }
}
