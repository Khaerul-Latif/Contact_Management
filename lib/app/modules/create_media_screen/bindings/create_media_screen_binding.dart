import 'package:get/get.dart';

import '../controllers/create_media_screen_controller.dart';

class CreateMediaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMediaScreenController>(
      () => CreateMediaScreenController(),
    );
  }
}
