import 'package:firebase_core/firebase_core.dart';
import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/app/modules/account_screen/controllers/account_screen_controller.dart';
import 'package:flubase_mobile/app/modules/contact_screen/controllers/contact_screen_controller.dart';
import 'package:flubase_mobile/app/modules/create_contact_screen/controllers/create_contact_screen_controller.dart';
import 'package:flubase_mobile/app/modules/create_media_screen/controllers/create_media_screen_controller.dart';
import 'package:flubase_mobile/app/modules/detail_media_screen/controllers/detail_media_screen_controller.dart';
import 'package:flubase_mobile/app/modules/edit_account_screen/controllers/edit_account_screen_controller.dart';
import 'package:flubase_mobile/app/modules/forget_password_screen/controllers/forget_password_screen_controller.dart';
import 'package:flubase_mobile/app/modules/map_screen/controllers/map_screen_controller.dart';
import 'package:flubase_mobile/app/modules/media_screen/controllers/media_screen_controller.dart';
import 'package:flubase_mobile/app/modules/onboarding_screen/controllers/onboarding_screen_controller.dart';
import 'package:flubase_mobile/app/modules/search_contact_screen/controllers/search_contact_screen_controller.dart';
import 'package:flubase_mobile/app/modules/search_media_screen/controllers/search_media_screen_controller.dart';
import 'package:flubase_mobile/app/modules/signin_screen/controllers/signin_screen_controller.dart';
import 'package:flubase_mobile/app/modules/signup_screen/controllers/signup_screen_controller.dart';
import 'package:flubase_mobile/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:flubase_mobile/app/modules/update_contact_screen/controllers/update_contact_screen_controller.dart';
import 'package:flubase_mobile/app/modules/update_media_screen/controllers/update_media_screen_controller.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/firebase_options.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initGet();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.routes,
      title: 'FluBase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kcPrimary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kcPrimary),
        primarySwatch: AppColors.primarysSwatch,
      ),
      // home: CreateMediaScreenView(),
      home: SplashScreenView(),
    );
  }
}

void initGet() {
  Get.put(OnboardingScreenController());
  Get.put(SignInScreenController());
  Get.put(SignUpScreenController());
  Get.put(ForgetPasswordScreenController());
  Get.put(MapScreenController());
  Get.put(ContactScreenController());
  Get.put(MediaScreenController());
  Get.put(AccountScreenController());
  Get.put(DetailMediaScreenController());
  Get.put(CreateContactScreenController());
  Get.put(CreateMediaScreenController());
  Get.put(UpdateContactScreenController());
  Get.put(UpdateMediaScreenController());
  Get.put(EditAccountScreenController());
  Get.put(AuthController());
  Get.put(SearchContactScreenController());
  Get.put(SearchMediaScreenController());
}
