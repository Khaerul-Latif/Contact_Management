import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/app/modules/media_screen/bindings/media_screen_binding.dart';
import 'package:flubase_mobile/app/modules/media_screen/controllers/media_screen_controller.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

class CreateMediaScreenController extends GetxController {
  late TextEditingController titleC;
  late TextEditingController descriptionC;
  late GlobalKey<FormState> formKey;
  late VideoPlayerController videoPlayerController;

  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final picker = ImagePicker();
  RxString mediaPath = RxString('');

  void createMedia(String uid, String title, String description, File media,
      User user, BuildContext context) async {
    try {
      CollectionReference data = db.collection(uid);
      String dateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      DocumentReference newDocRef = await data.add({
        'title': title,
        'description': description,
        'created-at': dateTime,
        'updated-at': dateTime,
      });

      String docId = newDocRef.id;

      uploadFile(media, docId, user);

      mediaPath.value = "";
      titleC.text = "";
      descriptionC.text = "";

      Get.find<MediaScreenController>().mediaUrl.value = media.path;

      CustomSnackbar(
          context: context,
          snackBarDelete: false,
          text: 'Media created successfully');
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
        String uid = user.uid;

        String fileType = getFileType(file.path);

        Reference storageReference =
            storage.ref().child('$uid/media/${docId}.$fileType');

        SettableMetadata metadata = SettableMetadata(
          customMetadata: {'uid': uid},
        );

        await storageReference.putFile(file, metadata);
        print('File berhasil diupload dengan metadata UID: $uid');
      } else {
        print('Pengguna tidak terautentikasi.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String getFileType(String fileName) {
    String extension = path.extension(fileName).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
      case '.png':
        return 'jpg';
      case '.mp4':
        return 'mp4';
      default:
        return 'unknown';
    }
  }

  Future<void> pickMedia() async {
    final pickedFile = await picker.pickMedia();
    print("File Bosssssss : ${pickedFile!.path}");
    if (pickedFile != null) {
      if (pickedFile.path.endsWith('.mp4')) {
        mediaPath.value = pickedFile.path;

        if (videoPlayerController != null) {
          videoPlayerController.dispose();
        }

        videoPlayerController =
            VideoPlayerController.file(File(mediaPath.value));
        print("File Bosssssss1 : ${mediaPath.value}");
        videoPlayerController.addListener(() {
          update();
        });
        videoPlayerController.setLooping(true);
        await videoPlayerController.initialize();
        return;
      } else {
        mediaPath.value = pickedFile.path;
        return;
      }
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    titleC = TextEditingController();
    descriptionC = TextEditingController();
    videoPlayerController = VideoPlayerController.file(File(mediaPath.value));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleC.dispose();
    descriptionC.dispose();
    formKey.currentState!.dispose();
    videoPlayerController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
