import 'package:firebase_auth/firebase_auth.dart';

import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  LocalStorage getStorage = LocalStorage();

  // Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<void> signInWithGoogle(RxBool isLoading) async {
    try {
      isLoading.value = true;

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        isLoading.value = false;
        return null;
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await auth.signInWithCredential(credential);
      /*  User users = auth.currentUser!;

      print("Full Name: " + users.displayName!);
      print("Email: " + users.email!);
      print("Email verifikasi: " + users.emailVerified.toString());
      print("User Id: " + users.uid);
      print('User registered successfully');*/
      User users = auth.currentUser!;
      print("User Id: " + users.uid);
      getStorage.setString('uid', auth.currentUser!.uid);
      getStorage.setString('email', auth.currentUser!.email!);
      getStorage.setBool('isLogin', true);

      getStorage.setString('fullname', auth.currentUser!.displayName ?? "");

      // String? uid = await getStorage.getString('uid');

      // String? email = getStorage.getString('email');

      // print("UID Nya Boss : $uid");
      // print("Email Nya Boss : $email");
      isLoading.value = false;

      Get.offAndToNamed(Routes.INDEX_SCREEN);

      print(auth.currentUser!.email);
    } catch (e) {
      isLoading.value = false;
      print("Error signing in with Google: $e");
    }
  }

  Future<void> signUp(String email, String password, String fullName,
      BuildContext context, bool isLoading) async {
    isLoading = true;
    if (GetUtils.isEmail(email)) {
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);

        // Get the user object
        User user = userCredential.user!;

        if (user != null) {
          // Set the display name
          await user.updateDisplayName(fullName);

          // Send email verification
          await user.sendEmailVerification();
          CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: 'Verification Link Sent!',
            subtitleAlertDialog:
                "Please check your email and click on the verification link to complete the registration process. If you don't see the email, please check your spam folder.",
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 200,
          );
          isLoading = false;
          Get.offAndToNamed(Routes.SIGNIN_SCREEN);
          // Retrieve the updated user object (with display name)
          User users = auth.currentUser!;

          print("Full Name: " + users.displayName!);
          print("Email: " + users.email!);
          print("Email verifikasi: " + users.emailVerified.toString());
          print("User Id: " + users.uid);
          print('User registered successfully');
          getStorage.setBool('isLogin', true);
          Get.back();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: "Email Already Registered",
            subtitleAlertDialog:
                "The email address you provided is already associated with an existing account. Please use a different email address or sign in with your existing account.",
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 180,
          );
          isLoading = false;
        } else if (e.code == 'invalid-email') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: "Invalid Email Address",
              subtitleAlertDialog:
                  "The provided email address is not valid. Please review and enter a valid email.",
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading = false;
        } else if (e.code == 'wrong-password') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: "Invalid Password",
              subtitleAlertDialog:
                  "The password you entered is not valid. Please review and re-enter your password.",
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading = false;
        } else {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: 'Too Many Requests',
              subtitleAlertDialog:
                  'We have blocked all requests from this device due to unusual activity.',
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading = false;
        }
        print('Failed with error code SIGNUP: ${e.code}');
        // Handle email tidak valid
      } catch (e) {
        print("Error: " + e.toString());
      }
    } else if (GetUtils.isEmail(email) == false) {
      CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: "Invalid Email Address",
          subtitleAlertDialog:
              "The provided email address is not valid. Please review and enter a valid email.",
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 130);
      isLoading = false;
    } else {
      CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: 'Too Many Requests',
          subtitleAlertDialog:
              'We have blocked all requests from this device due to unusual activity.',
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 130);
      isLoading = false;
    }
  }

  Future<void> resetPassword(
      String email, BuildContext context, RxBool isLoading) async {
    isLoading.value = true;
    try {
      if (GetUtils.isEmail(email)) {
        isLoading.value = true;
        await auth.sendPasswordResetEmail(email: email);
        /*List<String> listEmail = await auth.fetchSignInMethodsForEmail(email);
        print("Banyaknya Email : ${listEmail.length}");*/
        /* listEmail.forEach((element) {
          print("Emailnya : $element");
        });*/
        CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: "Password Reset Link Sent!",
          subtitleAlertDialog:
              "Please check your email and follow the instructions in the reset password link to update your password. If you don't see the email, please check your spam folder.",
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 180,
        );
        isLoading.value = false;
      } else if (GetUtils.isEmail(email) == false) {
        isLoading.value = true;
        CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: "Invalid Email Address",
            subtitleAlertDialog:
                "The provided email address is not valid. Please review and enter a valid email.",
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 130);
        isLoading.value = false;
      } else {
        isLoading.value = true;
        CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: 'Too Many Requests',
            subtitleAlertDialog:
                'We have blocked all requests from this device due to unusual activity.',
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 130);
        isLoading.value = false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        isLoading.value = true;
        CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: "Email Already Registered",
            subtitleAlertDialog:
                "The email address you provided is already associated with an existing account. Please use a different email address or sign in with your existing account.",
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 180);
        isLoading.value = false;
      } else if (e.code == 'invalid-email') {
        isLoading.value = true;
        CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: "Invalid Email Address",
            subtitleAlertDialog:
                "The provided email address is not valid. Please review and enter a valid email.",
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 130);
        isLoading.value = false;
      } else {
        isLoading.value = true;
        CustomAlertDialog(
            context: context,
            onPressedYes: () {
              Get.back();
            },
            titleAlertDialog: 'Too Many Requests',
            subtitleAlertDialog:
                'We have blocked all requests from this device due to unusual activity.',
            textActionYes: 'OK',
            doubleAction: false,
            heightContainer: 130);
        isLoading.value = false;
      }
      print('Failed with error code UPDATE PASSWORD: ${e.code}');
    } catch (e) {
      isLoading.value = true;
      CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: 'Too Many Requests',
          subtitleAlertDialog:
              'We have blocked all requests from this device due to unusual activity.',
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 130);
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
    getStorage.removeStorage('fullname');
    getStorage.removeStorage('uid');
    getStorage.removeStorage('email');
    getStorage.removeStorage('isLogin');
    Get.offAllNamed(Routes.SIGNIN_SCREEN);
  }

  Future<String?> getIdToken() async {
    User? user = auth.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }

  Future<void> signIn(String email, String password, BuildContext context,
      RxBool isLoading) async {
    isLoading.value = true;
    //  print("Pantau Loading 1: ${isLoading.value.toString()}");
    if (GetUtils.isEmail(email)) {
      isLoading.value = true;
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);

  
        // Get the user object
        User user = userCredential.user!;

        if (userCredential.user!.emailVerified == false) {
          CustomAlertDialog(
              context: context,
              onPressedYes: () async {
                await userCredential.user!.sendEmailVerification();
                Get.back();
              },
              onPressedNo: () {
                Get.back();
              },
              titleAlertDialog: 'Email Verification',
              subtitleAlertDialog: 'Your email is not verified.',
              textActionYes: 'Verif Now',
              textActionNo: 'Back',
              doubleAction: true,
              heightContainer: 130);
          isLoading.value = false;
          return;
        }

        // await auth.signInWithEmailAndPassword(email: email, password: password);
        User users = auth.currentUser!;
        // print("Pantau Loading 2: ${isLoading.value.toString()}");
        // print("Full Name: " + users.displayName!);
        // print("Email: " + users.email!);
        // print("Email verifikasi: " + users.emailVerified.toString());
        print("Id User: " + users.uid);
        getStorage.setString('uid', auth.currentUser!.uid);
        getStorage.setString('email', auth.currentUser!.email!);
        if (auth.currentUser!.displayName != "") {
          getStorage.setString('fullname', auth.currentUser!.displayName!);
        }

        getStorage.setBool('isLogin', true);
        // final uid = getStorage.getString('uid');

        isLoading.value = false;
        Get.offAndToNamed(Routes.INDEX_SCREEN);
        // print(auth.currentUser!.email);
        // Get.toNamed(Routes.INDEX_SCREEN);
      } on FirebaseAuthException catch (e) {
        // Format Email salah
        if (e.code == 'invalid-email') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: "Invalid Email Address",
              subtitleAlertDialog:
                  "The provided email address is not valid. Please review and enter a valid email.",
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading.value = false;
        }
        // Format Password salah
        else if (e.code == 'wrong-password') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: "Invalid Password",
              subtitleAlertDialog:
                  "The password you entered is not valid. Please review and re-enter your password.",
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading.value = false;
        }
        // email tidak di temukan
        else if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: "Email Not Found",
              subtitleAlertDialog:
                  "The provided email address was not found in our database. Please make sure you entered the correct email or sign up for a new account.",
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 160);
          isLoading.value = false;
        }
        // email tidak terverfikasi
        else if (e.code == 'user-not-verified') {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: 'Email Verification',
              subtitleAlertDialog: 'Your email is not verified.',
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading.value = false;
        }
        // saat melakukan permintaan terlalu banyak
        else {
          CustomAlertDialog(
              context: context,
              onPressedYes: () {
                Get.back();
              },
              titleAlertDialog: 'Too Many Requests',
              subtitleAlertDialog:
                  'We have blocked all requests from this device due to unusual activity.',
              textActionYes: 'OK',
              doubleAction: false,
              heightContainer: 130);
          isLoading.value = false;
        }
        print('Failed with error code SIGNIN: ${e.code}');
      } catch (e) {
        print("Error: " + e.toString());
      }
    } else if (GetUtils.isEmail(email) == false) {
      CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: "Invalid Email Address",
          subtitleAlertDialog:
              "The provided email address is not valid. Please review and enter a valid email.",
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 130);
      isLoading.value = false;
    } else {
      CustomAlertDialog(
          context: context,
          onPressedYes: () {
            Get.back();
          },
          titleAlertDialog: "Invalid Email Address",
          subtitleAlertDialog:
              "The provided email address is not valid. Please review and enter a valid email.",
          textActionYes: 'OK',
          doubleAction: false,
          heightContainer: 130);
      isLoading.value = false;
    }
  }
}
