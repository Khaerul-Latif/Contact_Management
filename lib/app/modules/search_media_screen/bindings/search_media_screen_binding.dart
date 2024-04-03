import 'package:get/get.dart';

import '../controllers/search_media_screen_controller.dart';

class SearchMediaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMediaScreenController>(
      () => SearchMediaScreenController(),
    );
  }
}
