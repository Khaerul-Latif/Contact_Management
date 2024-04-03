import 'package:get/get.dart';

import '../controllers/detail_media_screen_controller.dart';

class DetailMediaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMediaScreenController>(
      () => DetailMediaScreenController(),
    );
  }
}
