import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class MediaScreenController extends GetxController {
  late TextEditingController searchC;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  String? uid;
  var mediaUrl = ''.obs;

  Stream<QuerySnapshot<Object?>> getMedia(String uid) {
    print("Uid Query : " + uid);
    CollectionReference data = db.collection(uid);
    return data.orderBy('updated-at', descending: true).snapshots();
  }

  Future<String> getContentMedia(String uid, String docsId) async {
    try {
      Reference storageReference = storage.ref().child('$uid/media/');
      ListResult listResult = await storageReference.list();

      String downloadURLs = '';

      for (var item in listResult.items) {
        String docId = item.name;
        print("Doc ID : $docId");

        if (docId.startsWith(docsId)) {
          if (docId.endsWith(".jpg")) {
            downloadURLs =
                await storageReference.child('$docId').getDownloadURL();
            // Break out of the loop if a .jpeg file is found
            break;
          } else if (docId.endsWith(".mp4")) {
            downloadURLs =
                await storageReference.child('$docId').getDownloadURL();
            // Break out of the loop if an .mp4 file is found
            break;
          }
        }
      }

      return downloadURLs;
    } on FirebaseException catch (e) {
      print('Firebase Storage Exception: ${e.code}');
      return '';
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  deleteMedia(String docsId, String uid, BuildContext context) async {
    DocumentReference docData = db.collection(uid).doc(docsId);
    Reference storageReference = storage.ref().child('$uid/media/');
    ListResult listResult = await storageReference.list();

    try {
      // ignore: use_build_context_synchronously
      CustomAlertDialog(
        context: context,
        onPressedYes: () async {
          for (var item in listResult.items) {
            String docId = item.name;
            print("Doc ID : $docId");

            if (docId.contains(docsId)) {
              storageReference.child('$docId').delete();
            }
          }
          await docData.delete();
          //  await storageReference.delete();

          // for (var item in listResult.items) {
          //   String docId = item.name;

          //   if (docId.contains(docsId)) {
          //     storageReference.child('$docsId').delete();
          //      print("Doc ID : $docId");
          //     break;
          //     // Break out of the loop if a .jpeg file is found
          //   }
          // }

          Get.back();
          CustomSnackbar(
              context: context,
              snackBarDelete: true,
              text: "Media deleted successfully");
        },
        onPressedNo: () {
          Get.back();
        },
        titleAlertDialog: "Delete Media",
        subtitleAlertDialog:
            "Are you sure you want to delete this media? This action cannot be undone.",
        textActionYes: 'Yes',
        textActionNo: 'No',
        doubleAction: true,
        heightContainer: 180,
      );
    } catch (e) {}
  }

  final count = 0.obs;
  @override
  void onInit() async {
    searchC = TextEditingController();
    await LocalStorage().getString('uid').then((value) => uid = value);
    super.onInit();
  }

  String getFileType(String fileName) {
    String extension = path.extension(fileName).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
      case '.png':
        return '.jpg';
      case '.mp4':
        return '.mp4';
      default:
        return 'unknown';
    }
  }

  List<Media> listMedia = [
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern T2rks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title: "How you draw a sketch?",
        image: "assets/images/dummy_media1.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    Media(
        title:
            "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
        image: "assets/images/dummy_media2.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
  ].obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}

class Media {
  String title;
  String? image;
  String? description;
  Media({
    required this.title,
    this.image,
    this.description,
  });
}
