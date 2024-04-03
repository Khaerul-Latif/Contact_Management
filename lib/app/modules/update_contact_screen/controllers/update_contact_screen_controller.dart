import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/app/modules/contact_screen/controllers/contact_screen_controller.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateContactScreenController extends GetxController {
  //TODO: Implement CreateContactScreenController
  late TextEditingController nameC;
  late TextEditingController numberC;
  late GlobalKey<FormState> formKey;
  final picker = ImagePicker();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  var imagePath = ''.obs;

  Future<DocumentSnapshot<Object?>> getDocsId(String docsId, String uid) async {
    DocumentReference docRef = db.collection(uid).doc(docsId);
    return docRef.get();
  }

  void updateContact(String name, String number, String imageUrl,
      String createdAt, String docsId, String uid, BuildContext context) async {
    DocumentReference docData = db.collection(uid).doc(docsId);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    try {
      await docData.update({
        'name': name,
        'number': number,
        'created-at': createdAt,
        'updated-at': formattedDateTime,
      });
      Reference storageReference =
          storage.ref().child('$uid/contact/${docsId}.jpg');
      // .putFile(File(imageUrl)
      SettableMetadata metadata = SettableMetadata(
        customMetadata: {'uid': uid},
      );
      await storageReference.putFile(File(imageUrl), metadata);
      Get.find<ContactScreenController>().imageUrl.value = imageUrl;

      print("imageUrl.value ${imageUrl}");

      CustomSnackbar(
        context: context,
        snackBarDelete: false,
        text: 'Contact update successfully',
      );
      Get.back();
    } on FirebaseException catch (e) {
      print("Print Error Kode :  ${e.code}");
    }
  }

  Future<void> pickImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      Get.back();
    }
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      Get.back();
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    nameC = TextEditingController();
    numberC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // nameC.dispose();
    // numberC.dispose();
    formKey.currentState!.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
