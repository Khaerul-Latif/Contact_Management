part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const ONBOARDING_SCREEN = _Paths.ONBOARDING_SCREEN;
  static const SIGNIN_SCREEN = _Paths.SIGNIN_SCREEN;
  static const FORGET_PASSWORD_SCREEN = _Paths.FORGET_PASSWORD_SCREEN;
  static const SIGNUP_SCREEN = _Paths.SIGNUP_SCREEN;
  static const MAP_SCREEN = _Paths.MAP_SCREEN;
  static const MEDIA_SCREEN = _Paths.MEDIA_SCREEN;
  static const CONTACT_SCREEN = _Paths.CONTACT_SCREEN;
  static const ACCOUNT_SCREEN = _Paths.ACCOUNT_SCREEN;
  static const DETAIL_MEDIA_SCREEN = _Paths.DETAIL_MEDIA_SCREEN;
  static const CREATE_MEDIA_SCREEN = _Paths.CREATE_MEDIA_SCREEN;
  static const CREATE_CONTACT_SCREEN = _Paths.CREATE_CONTACT_SCREEN;
  static const UPDATE_CONTACT_SCREEN = _Paths.UPDATE_CONTACT_SCREEN;
  static const UPDATE_MEDIA_SCREEN = _Paths.UPDATE_MEDIA_SCREEN;
  static const INDEX_SCREEN = _Paths.INDEX_SCREEN;
  static const EDIT_ACCOUNT_SCREEN = _Paths.EDIT_ACCOUNT_SCREEN;
  static const SEARCH_CONTACT_SCREEN = _Paths.SEARCH_CONTACT_SCREEN;
  static const SEARCH_MEDIA_SCREEN = _Paths.SEARCH_MEDIA_SCREEN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH_SCREEN = '/';
  static const ONBOARDING_SCREEN = '/onboarding-screen';
  static const SIGNIN_SCREEN = '/signin-screen';
  static const FORGET_PASSWORD_SCREEN = '/forget-password-screen';
  static const SIGNUP_SCREEN = '/signup-screen';
  static const MAP_SCREEN = '/map-screen';
  static const MEDIA_SCREEN = '/media-screen';
  static const CONTACT_SCREEN = '/contact-screen';
  static const ACCOUNT_SCREEN = '/account-screen';
  static const DETAIL_MEDIA_SCREEN = '/detail-media-screen';
  static const CREATE_MEDIA_SCREEN = '/create-media-screen';
  static const CREATE_CONTACT_SCREEN = '/create-contact-screen';
  static const UPDATE_CONTACT_SCREEN = '/update-contact-screen';
  static const UPDATE_MEDIA_SCREEN = '/update-media-screen';
  static const INDEX_SCREEN = '/index-screen';
  static const EDIT_ACCOUNT_SCREEN = '/edit-account-screen';
  static const SEARCH_CONTACT_SCREEN = '/search-contact-screen';
  static const SEARCH_MEDIA_SCREEN = '/search-media-screen';
}
