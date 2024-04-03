import 'package:get/get.dart';

import '../../utils/index_screen.dart';
import '../modules/account_screen/bindings/account_screen_binding.dart';
import '../modules/account_screen/views/account_screen_view.dart';
import '../modules/contact_screen/bindings/contact_screen_binding.dart';
import '../modules/contact_screen/views/contact_screen_view.dart';
import '../modules/create_contact_screen/bindings/create_contact_screen_binding.dart';
import '../modules/create_contact_screen/views/create_contact_screen_view.dart';
import '../modules/create_media_screen/bindings/create_media_screen_binding.dart';
import '../modules/create_media_screen/views/create_media_screen_view.dart';
import '../modules/detail_media_screen/bindings/detail_media_screen_binding.dart';
import '../modules/detail_media_screen/views/detail_media_screen_view.dart';
import '../modules/edit_account_screen/bindings/edit_account_screen_binding.dart';
import '../modules/edit_account_screen/views/edit_account_screen_view.dart';
import '../modules/forget_password_screen/bindings/forget_password_screen_binding.dart';
import '../modules/forget_password_screen/views/forget_password_screen_view.dart';
import '../modules/map_screen/bindings/map_screen_binding.dart';
import '../modules/map_screen/views/map_screen_view.dart';
import '../modules/media_screen/bindings/media_screen_binding.dart';
import '../modules/media_screen/views/media_screen_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/search_contact_screen/bindings/search_contact_screen_binding.dart';
import '../modules/search_contact_screen/views/search_contact_screen_view.dart';
import '../modules/search_media_screen/bindings/search_media_screen_binding.dart';
import '../modules/search_media_screen/views/search_media_screen_view.dart';
import '../modules/signin_screen/bindings/signin_screen_binding.dart';
import '../modules/signin_screen/views/signin_screen_view.dart';
import '../modules/signup_screen/bindings/signup_screen_binding.dart';
import '../modules/signup_screen/views/signup_screen_view.dart';
import '../modules/update_contact_screen/bindings/update_contact_screen_binding.dart';
import '../modules/update_contact_screen/views/update_contact_screen_view.dart';
import '../modules/update_media_screen/bindings/update_media_screen_binding.dart';
import '../modules/update_media_screen/views/update_media_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN_SCREEN,
      page: () => SignInScreenView(),
      binding: SignInScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_SCREEN,
      page: () => ForgetPasswordScreenView(),
      binding: ForgetPasswordScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_SCREEN,
      page: () => SignUpScreenView(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAP_SCREEN,
      page: () => MapScreenView(),
      binding: MapScreenBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA_SCREEN,
      page: () => MediaScreenView(),
      binding: MediaScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_SCREEN,
      page: () => ContactScreenView(),
      binding: ContactScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SCREEN,
      page: () => AccountScreenView(),
      binding: AccountScreenBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MEDIA_SCREEN,
      page: () => DetailMediaScreenView(),
      binding: DetailMediaScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_MEDIA_SCREEN,
      page: () => CreateMediaScreenView(),
      binding: CreateMediaScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_CONTACT_SCREEN,
      page: () => CreateContactScreenView(),
      binding: CreateContactScreenBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_CONTACT_SCREEN,
      page: () => UpdateContactScreenView(),
      binding: UpdateContactScreenBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_MEDIA_SCREEN,
      page: () => UpdateMediaScreenView(),
      binding: UpdateMediaScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACCOUNT_SCREEN,
      page: () => EditAccountScreenView(),
      binding: EditAccountScreenBinding(),
    ),
    GetPage(
      name: _Paths.INDEX_SCREEN,
      page: () => IndexScreen(),
    ),
    GetPage(
      name: _Paths.SEARCH_CONTACT_SCREEN,
      page: () => SearchContactScreenView(),
      binding: SearchContactScreenBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MEDIA_SCREEN,
      page: () => const SearchMediaScreenView(),
      binding: SearchMediaScreenBinding(),
    ),
  ];
}
