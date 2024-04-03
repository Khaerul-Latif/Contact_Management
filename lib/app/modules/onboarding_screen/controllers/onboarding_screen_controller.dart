// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreenController extends GetxController {
  //TODO: Implement OnboardingScreenController
  var currentIndex = 0.obs;
  late PageController controllerPage;
  final primaryColor = AppColors.kcPrimary;
  LocalStorage getStorage = LocalStorage();

  List<OnBoarding> listOnboarding = [
    OnBoarding(
      image: 'assets/images/onboarding1.png',
      title: 'Enhanced Privacy Management',
      description:
          'Protect your privacy with secure login using your Google account in the Management App. Manage and control your personal data with intelligence and comfort.',
    ),
    OnBoarding(
      image: 'assets/images/onboarding2.png',
      title: 'Explore the World with Efficient Location Management',
      description:
          'Explore the map, save your favorite locations, and share your journeys. Our Management App makes it easy to organize and share locations in one place.',
    ),
    OnBoarding(
      image: 'assets/images/onboarding3.png',
      title: 'Optimize Connections with Personal Contact Management',
      description:
          'Organize and categorize your contact list with our Management App. Not only manage phone numbers but also build deeper connections with those important to you.',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    controllerPage = PageController(initialPage: 0);
    controllerPage.addListener(() {
      currentIndex.value = controllerPage.page?.round() ?? 0;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controllerPage.dispose();
    super.onClose();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
    update(); // This triggers a rebuild
  }

  void nextPage() {
    if (currentIndex.value < listOnboarding.length - 1) {
      controllerPage.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

class OnBoarding {
  String image;
  String title;
  String description;
  OnBoarding({
    required this.image,
    required this.title,
    required this.description,
  });
}
