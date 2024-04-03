import 'package:firebase_storage/firebase_storage.dart';
import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/utils/local_storage.dart';
import 'package:get/get.dart';

class AccountScreenController extends GetxController {
  //TODO: Implement AccountScreenController
  final authController = Get.put(AuthController());
  FirebaseStorage storage = FirebaseStorage.instance;

  RxString? fullName = "".obs;
  RxString? email = "".obs;
  var uids = LocalStorage().getString('uid');
  RxString? imageUrl = ''.obs;

  RxString? imageFire = ''.obs;
  Future<void> initProfilAccount() async {
    try {
      fullName!.value = await LocalStorage().getString('fullname');
      email!.value = await LocalStorage().getString('email');
    } catch (e) {
      print(" Error Future Builder : $e");
    }
  }

  Future<void> fetchData() async {
    try {
      // Fetch full name
      fullName!.value = await LocalStorage().getString('fullname');

      // Fetch email
      email!.value = await LocalStorage().getString('email');

      // Fetch image URL
      imageUrl!.value = await getPhotoContact();
    } catch (e) {
      // Handle any errors that occurred during data fetching
      print('Error fetching data: $e');
    }
  }

  Future<String> getPhotoContact() async {
    try {
      var uid = await uids;
      print('UID Boss : $uid');
      Reference storageReference = await storage.ref().child('$uid/${uid}.jpg');
      imageUrl!.value = await storageReference.getDownloadURL();
      return imageUrl!.value;
    } catch (error) {
      if (error is FirebaseException && error.code == 'object-not-found') {
        // Objek tidak ditemukan, berikan nilai default atau tindakan yang sesuai.
        return 'path/to/default/image.jpg';
      }

      // Tangani kesalahan lain jika diperlukan.
      throw error;
    }
  }

  final count = 0.obs;

  @override
  void onInit() async {
    var getPhoto = await getPhotoContact();
    imageUrl != '' ? getPhoto : imageUrl;
    await initProfilAccount(); // Panggil initData pada onInit
    // print('Init Image Obs : ${imageUrl}');
    // print('Init Image : ${imageUrl!.value}');
    // print('Init UID : ${await uids}');
    // print("Init Photo : ${getPhoto}");
    // // print('Init FullName Obs : ${fullName}');
    // print('Init FullName : ${fullName.value}');
    // print('Init Email Obs : ${email}');
    // print('Init Email : ${email.value}');
    super.onInit();
  }

  @override
  void onReady() async {
    var getPhoto = await getPhotoContact();
    imageUrl ?? getPhoto;
    // print('OnReady Image Obs : ${imageUrl}');
    // print('OnReady Image : ${imageUrl!.value}');
    // print('OnReady FullName Obs : ${fullName}');
    // print('OnReady FullName : ${fullName.value}');
    // print('OnReady Email Obs : ${email}');
    // print('OnReady Email : ${email.value}');
    super.onReady();
  }

  @override
  void onClose() async {
    // await initProfilAccount();
    // imageUrl == '' ? getPhotoContact() : imageUrl;
    // print('OnClose Image Obs : ${imageUrl}');
    // print('OnClose Image : ${imageUrl.value}');
    // print('OnClose FullName Obs : ${fullName}');
    // print('OnClose FullName : ${fullName.value}');
    // print('OnClose Email Obs : ${email}');
    // print('OnClose Email : ${email.value}');
    super.onClose();
  }

  void increment() => count.value++;
}
