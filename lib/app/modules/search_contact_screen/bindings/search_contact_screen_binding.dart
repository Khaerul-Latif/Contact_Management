import 'package:get/get.dart';

import '../controllers/search_contact_screen_controller.dart';

class SearchContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchContactScreenController>(
      () => SearchContactScreenController(),
    );
  }
}
