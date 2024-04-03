import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_contact_screen_controller.dart';

class SearchContactScreenView extends GetView<SearchContactScreenController> {
  const SearchContactScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.kcPrimary,
        toolbarHeight: 120,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Column(
          children: [
            Text(
              'Search Contact',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFieldSearch(
              controller: controller.searchC,
              hintText: 'search name and number',
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      body: ShimmerList(),
    );
  }
}
