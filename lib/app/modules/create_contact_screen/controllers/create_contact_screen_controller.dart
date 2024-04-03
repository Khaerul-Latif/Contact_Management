import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/app/modules/contact_screen/controllers/contact_screen_controller.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateContactScreenController extends GetxController {
  //TODO: Implement CreateContactScreenController
  late TextEditingController nameC;
  late TextEditingController numberC;
  late GlobalKey<FormState> formKey;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  // var baseUrlStorage = 'gs://flubase01.appspot.com';

  final picker = ImagePicker();
  RxString imagePath = RxString('');

  void createContact(String uid, String name, String number, File image,
      User user, BuildContext context) async {
    try {
      // String imageUrl = await uploadImageToStorage(uid, imageFile);
      CollectionReference data = db.collection(uid);
      String formattedDateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      DocumentReference newDocRef = await data.add({
        'name': name,
        'number': number,
        'created-at': formattedDateTime,
        'updated-at': formattedDateTime,
      });

      String docId = newDocRef.id;
      // LocalStorage().setString('docid', docId);

// docId sekarang berisi ID dokumen yang baru saja dibuat
      // print('Dokumen berhasil dibuat dengan ID: $docId');
      uploadFile(image, docId, user);

      imagePath.value = '';
      nameC.text = "";
      numberC.text = "";
      // Reference storageReference =
      //     storage.ref().child('$uid/contact/$docId.jpg');

      // String imageItemContact = await storageReference.getDownloadURL();
      // print("Photo Contact: " + imageItemContact);

      Get.find<ContactScreenController>().imageUrl.value = image.path;

      CustomSnackbar(
          context: context,
          snackBarDelete: false,
          text: 'Contact created successfully');
      // print(formattedDateTime);
      Get.back();
    } on FirebaseException catch (e) {
      print('Firebase Storage Error: ${e.message}');
      print('Firebase Storage Error: ${e.code}');
    } catch (e) {
      print('Error creating contact: $e');
    }
  }

  Future<void> uploadFile(File file, String docId, User user) async {
    try {
      if (user != null) {
        // Mendapatkan UID dari pengguna yang saat ini masuk
        String uid = user.uid;

        // Mendapatkan referensi penyimpanan di Firebase Storage
        Reference storageReference =
            storage.ref().child('$uid/contact/${docId}.jpg');
        // Reference gsstorageReference =
        //     storage.refFromURL('$baseUrlStorage/$uid/contact/${docId}.jpg');

        // Membuat metadata dengan UID
        SettableMetadata metadata = SettableMetadata(
          customMetadata: {'uid': uid},
        );

        // Melakukan upload file dengan metadata
        await storageReference.putFile(file, metadata);

        print('File berhasil diupload dengan metadata UID: $uid');
      } else {
        print('Pengguna tidak terautentikasi.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    nameC = TextEditingController();
    numberC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameC.dispose();
    numberC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

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
    }
  }

  void increment() => count.value++;
}
