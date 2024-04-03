import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreenController extends GetxController {
  late TextEditingController searchC;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? uid;
  // String? docId = LocalStorage().getString('docid');
  var imageUrl = ''.obs;

  RxString searchQuery = ''.obs;
  bool showNoSearchData = false;

  // Fungsi untuk melakukan pencarian
  void updateSearch(String query) {
    searchQuery.value = query;
  }

  Stream<QuerySnapshot<Object?>> getContact(String uid) {
    CollectionReference data = db.collection(uid);
    return data.orderBy('updated-at', descending: true).snapshots();
  }

  // Future<String> fetchContactPhoto(String uid, String contactId) async {
  //   String photoUrl = await getPhotoContact(uid, contactId);
  //   return imageUrl.value = photoUrl;
  // }

  Future<String> getPhotoContact(String uid, String docId) async {
    try {
      Reference storageReference =
          storage.ref().child('$uid/contact/$docId.jpg');

      // Using await here to wait for the download URL
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      if (e.code == "object-not-found") {
        CollectionReference contactsCollection =
            FirebaseFirestore.instance.collection(uid);

        // Reference to a specific document using uid and docId
        DocumentReference documentReference = contactsCollection.doc(docId);

        // Get the document snapshot
        DocumentSnapshot documentSnapshot = await documentReference.get();
//  print("Name Full Contact ${name}");
        // Check if the document exists and has a "name" field
        if (documentSnapshot.exists && documentSnapshot.data() != null) {
          // Access the "name" field
          String name = documentSnapshot.get('name');

          return name;
        } else {
          return "Document not found or does not have a 'name' field.";
        }
      }

      // Handle specific Firebase Storage exceptions
      print('Firebase Storage Exception: ${e.code}');
      return "Error Pag Firebase";
    } catch (e) {
      // Handle generic exceptions
      print('Error: $e');
      return "Error Page";
    }
  }

  // void updateSearch(String value) {
  //   print(' $value');
  //   searchC.text = value;
  //   update();
  // }

  bool isNetworkImage(String imageUrl) {
    RegExp regExp = RegExp(r'^https?://', caseSensitive: false);
    return regExp.hasMatch(imageUrl);
  }

  deleteContact(String docId, String uid, BuildContext context) {
    DocumentReference docData = db.collection(uid).doc(docId);
    Reference docImage = storage.ref().child('$uid/contact/${docId}.jpg');
    try {
      CustomAlertDialog(
        context: context,
        onPressedYes: () async {
          await docData.delete();
          docImage.delete();

          CustomSnackbar(
              context: context,
              snackBarDelete: true,
              text: "Contact deleted successfully");
          Get.back();
        },
        onPressedNo: () {
          Get.back();
        },
        titleAlertDialog: "Delete Contact",
        subtitleAlertDialog:
            "Are you sure you want to delete this contact? This action cannot be undone.",
        textActionYes: 'Yes',
        textActionNo: 'No',
        doubleAction: true,
        heightContainer: 180,
      );
    } catch (e) {}
  }

  @override
  void onInit() async {
    searchC = TextEditingController();
    await LocalStorage().getString('uid').then((value) => uid = value);
    // imageUrl.value  == '' ? getPhotoContact(uid!, docId!) : imageUrl;
    super.onInit();
  }

  @override
  void onReady() {
    // imageUrl.value == '' ? getPhotoContact(uid!, docId!) : imageUrl;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchC.dispose();
    // imageUrl.value == '' ? getPhotoContact(uid!, docId!) : imageUrl;
  }
}
