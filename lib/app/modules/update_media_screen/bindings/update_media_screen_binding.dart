import 'package:get/get.dart';

import '../controllers/update_media_screen_controller.dart';

class UpdateMediaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateMediaScreenController>(
      () => UpdateMediaScreenController(),
    );
  }
}
