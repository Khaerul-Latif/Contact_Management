// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/app/modules/account_screen/controllers/account_screen_controller.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountScreenController extends GetxController {
  //TODO: Implement EditAccountScreenController
  late TextEditingController fullNameC;
  late TextEditingController emailC;
  late GlobalKey<FormState> formKey;

  FirebaseAuth auth = FirebaseAuth.instance;
  // RxBool isLoading = false.obs;
  FirebaseStorage storage = FirebaseStorage.instance;

  final picker = ImagePicker();
  RxString imagePath = RxString('');

  Future<void> pickImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      Get.back();
      return;
    }
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      Get.back();
      // return;
    }
  }

  void updateAccount(String fullName, String email, BuildContext context,
   File file) async {
    try {
      // isLoading.value = true;
      String? uid = await LocalStorage().getString('uid');
      if (email != '' && GetUtils.isEmail(email)) {
        // isLoading.value = true;
        // Update Email dan FullName
        auth.currentUser!.updateEmail(email);
        auth.currentUser!.updateDisplayName(fullName);
        print('Current User: Email $email, FullName $fullName');

        // Masukkan keDalam shared prefrerence
        // print('isLoading failed Loading Bossqu ${isLoading}');
        LocalStorage().setString('email', email);
        LocalStorage().setString('fullname', fullName);

        print("Foto DiUpdate : ${file}");
          print('Current User1: Email $email, FullName1L $fullName');

        // Rx<Future<String>> emailLocal =
        //     await LocalStorage().getString('email').obs;
        // Rx<Future<String>> fullNameLocal =
        //     await LocalStorage().getString('fullname').obs;
        // print("print LocalStorage : Email ${(await emailLocal) as RxString}, FullName ${(await fullNameLocal) as RxString}");

        Reference storageReference = storage.ref().child('$uid/${uid}.jpg');
        // Membuat metadata dengan UID
        SettableMetadata metadata = SettableMetadata(
          customMetadata: {'uid': uid},
        );

        // Melakukan upload file dengan metadata
        await storageReference.putFile(file, metadata);
 print('Full Name Bossqu : $fullName');
        print('Email Bossqu : $email');
        print('File Bossqu : ${file.path.obs}');
        // print('File Bossqu : ${imagePath}'); 
        // fullNameC.dispose();
        // Update Rx variables in AccountScreenController

        String downloadURL = await storageReference.getDownloadURL();
        Get.find<AccountScreenController>().fullName!.value = fullName;
        Get.find<AccountScreenController>().email!.value = email;
        Get.find<AccountScreenController>().imageUrl!.value = downloadURL;

        imagePath.value = downloadURL;
        // isLoading.value = false;

        CustomSnackbar(
          context: context,
          snackBarDelete: false,
          text: 'Account edit successfully',
        );

        Get.back();
       
        // print('isLoading Succes Loading Bossqu ${isLoading}');

        // emailC.dispose();
      } else {
        // isLoading.value = false;
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
      }
    } on FirebaseAuthException catch (e) {
      print('Error Page Edit Account : ${e.code}');
    } catch (e) {
      print(e);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    fullNameC = TextEditingController();
    emailC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // fullNameC.dispose();
    // emailC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
