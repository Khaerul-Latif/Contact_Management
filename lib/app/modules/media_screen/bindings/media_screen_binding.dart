import 'package:get/get.dart';

import '../controllers/media_screen_controller.dart';

class MediaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaScreenController>(
      () => MediaScreenController(),
    );
  }
}
