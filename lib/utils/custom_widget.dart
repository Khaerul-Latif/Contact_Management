import 'dart:io';

import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget CustomElevatedButton(
    {required String text,
    Color? buttonColor,
    required VoidCallback onPressed,
    required bool icon,
    double? width,
    String? srcImage,
    bool? isLoading}) {
  return SizedBox(
    height: 40,
    width: width ?? double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: isLoading == true
            ? MaterialStateProperty.all(buttonColor!.withOpacity(0.5) ??
                AppColors.kcPrimary.withOpacity(0.5))
            : MaterialStateProperty.all(buttonColor ?? AppColors.kcPrimary),
        foregroundColor: MaterialStateProperty.all(AppColors.kcWhitePrimary),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 15),
        ),
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: icon != true
          ? isLoading == true
              ? Container(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.kcWhitePrimary,
                  ),
                )
              : Text(text)
          : isLoading == true
              ? Container(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.kcWhitePrimary,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: AppColors.kcWhitePrimary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 28,
                      width: 28,
                      child: Center(
                        child: Image.asset(
                          'assets/icons/google.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
    ),
  );
}

Text CustomComponenAuthText(
    {required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? colorText}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize ?? 24,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: colorText ?? AppColors.kcBlackPrimary,
    ),
  );
}

Text CustomAppBarAuthText(
    {required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? colorText}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: colorText ?? AppColors.kcPrimary,
    ),
  );
}

TextButton CustomAuthTextButton(
    {required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? colorText,
    required VoidCallback onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: colorText ?? AppColors.kcSecondary,
      ),
    ),
  );
}

TextFormField CustomTextFormField(
    {required TextEditingController controller,
    required String textLabelnHint,
    required TextInputType textInputType,
    int? maxLines}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty || value == '') {
        return "$textLabelnHint is required";
      }
      return null;
    },
    keyboardType: textInputType,
    textCapitalization: TextCapitalization.words,
    maxLines: maxLines ?? 1,
    decoration: InputDecoration(
      labelText: textLabelnHint,
      hintText: textLabelnHint,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      alignLabelWithHint: true,
    ),
  );
}

TextFormField CustomTextFieldPassword(
    {required TextEditingController controller,
    String? confirm,
    required String textLabelnHint,
    required TextInputType textInputType,
    required VoidCallback onPressed,
    required String? Function(String?)? validator,
    required bool obPass}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: textInputType,
    obscureText: obPass,
    decoration: InputDecoration(
      labelText: textLabelnHint,
      hintText: textLabelnHint,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(
          obPass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
      ),
    ),
  );
}

TextFormField CustomTextFieldSearch({
  required TextEditingController controller,
  required String hintText,
  Function(String?)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.kcBorderColorSearch,
      hintText: "Search $hintText",
      prefixIcon: Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
        child: Image.asset(
          height: 24,
          width: 24,
          'assets/icons/search.png',
        ),
      ),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    ),
  );
}

Container CustomerContentMedia(
    {required String title,
    required Widget media,
    required VoidCallback onPressed}) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      color: AppColors.kcWhitePrimary,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomComponenAuthText(text: title, fontSize: 16)),
            InkWell(
              onTap: onPressed,
              child: const ImageIcon(
                AssetImage(
                  'assets/icons/more.png',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        media,
      ],
    ),
  );
}

Future<dynamic> CustomShowBottomDialog({
  required BuildContext context,
  required VoidCallback onPressedUpdate,
  required VoidCallback onPressedDelete,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    backgroundColor: AppColors.kcWhitePrimary,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: onPressedUpdate,
              child: Row(
                children: [
                  const ImageIcon(AssetImage('assets/icons/update.png')),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomAppBarAuthText(
                    text: "Update",
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.kcBlackPrimary,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              color: Color(0xffDFDFDF),
            ),
            InkWell(
              onTap: onPressedDelete,
              child: Row(
                children: [
                  const ImageIcon(AssetImage('assets/icons/delete.png')),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomAppBarAuthText(
                    text: "Delete",
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.kcBlackPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> CustomAlertDialog({
  required BuildContext context,
  required VoidCallback onPressedYes,
  VoidCallback? onPressedNo,
  required String titleAlertDialog,
  required String subtitleAlertDialog,
  String? textActionNo,
  double? heightContainer,
  required String textActionYes,
  bool? doubleAction,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: const Color(0xffffffff),
        content: Container(
          height: heightContainer ?? 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CustomAppBarAuthText(
                  text: titleAlertDialog,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  colorText: AppColors.kcBlackPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CustomAppBarAuthText(
                    text: subtitleAlertDialog,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    colorText: AppColors.kcDescription),
              ),
              const SizedBox(height: 20),
              doubleAction == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: onPressedNo ?? () {},
                          child: Text(
                            textActionNo ?? "",
                            style: TextStyle(color: AppColors.kcSecondary),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomElevatedButton(
                          width: 100,
                          text: textActionYes,
                          onPressed: onPressedYes,
                          icon: false,
                        )
                      ],
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: CustomElevatedButton(
                        width: 50,
                        text: textActionYes,
                        onPressed: onPressedYes,
                        icon: false,
                      ),
                    ),
            ],
          ),
        ),
      );
    },
  );
}

AppBar CustomAppBar({
  required TextEditingController searchC,
  required String title,
}) {
  return AppBar(
    toolbarHeight: 120,
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.start,
            title,
            style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFieldSearch(
            controller: searchC,
            hintText: title.toLowerCase(),
          ),
        ],
      ),
    ),
  );
}

TextFormField CustomTextFormFieldNoBorder(
    {required TextEditingController controller,
    required TextInputType textInputType,
    required String textLabelnHint}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty || value == '') {
        return "$textLabelnHint is required";
      }
      return null;
    },
    keyboardType: textInputType,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
      labelText: textLabelnHint,
      hintText: textLabelnHint,
      fillColor: Colors.white,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      alignLabelWithHint: true,
    ),
  );
}

ScaffoldFeatureController CustomSnackbar(
    {required BuildContext context,
    required bool snackBarDelete,
    required String text}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: snackBarDelete == true
          ? AppColors.bgSnackBarDelete
          : AppColors.bgSnackBarCreate,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 130,
          right: 20,
          left: 20),
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            snackBarDelete == true
                ? 'assets/icons/succes_delete.png'
                : 'assets/icons/succes_create.png',
            height: 24,
            width: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Future<dynamic> CustomAlertDialogContact({
  required BuildContext context,
  required VoidCallback onPressedGallery,
  VoidCallback? onPressedCamera,
  required String titleAlertDialog,
  required String subtitleAlertDialog,
  String? textActionCamera,
  double? heightContainer,
  required String textActionGallery,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: const Color(0xffffffff),
        content: Container(
          height: heightContainer ?? 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CustomAppBarAuthText(
                  text: titleAlertDialog,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  colorText: AppColors.kcBlackPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CustomAppBarAuthText(
                  text: subtitleAlertDialog,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  colorText: AppColors.kcDescription,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomElevatedButton(
                    text: textActionCamera!,
                    onPressed: onPressedCamera!,
                    width: 100,
                    icon: false,
                  ),
                  const SizedBox(width: 10),
                  CustomElevatedButton(
                    width: 100,
                    text: textActionGallery,
                    onPressed: onPressedGallery,
                    icon: false,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: AppColors.kcSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget ShimmerList() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.kcBgListContact,
            border: Border.all(
              color: AppColors.kcBlackPrimary,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            trailing: Icon(Icons.delete, color: AppColors.kcBlackPrimary),
            leading: CircleAvatar(
              backgroundColor: AppColors.kcWhitePrimary,
            ),
            title: CustomAppBarAuthText(
                text: 'Loading...', colorText: AppColors.kcHeadingDua),
            subtitle: CustomAppBarAuthText(
                text: 'Loading...', colorText: AppColors.kcHeadingDua),
          ),
        );
      },
    ),
  );
}

Widget ShimmerAccount() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kcBgPhotoContact,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150, // Sesuaikan lebar container dengan kebutuhan
              height: 24, // Sesuaikan tinggi container dengan kebutuhan
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 80, // Sesuaikan lebar container dengan kebutuhan
              height: 16, // Sesuaikan tinggi container dengan kebutuhan
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ShimmerListMedia() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 5, // Adjust the itemCount as needed
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150, // Adjust width as needed
                    height: 20,
                    color: Colors.white,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 150, // Adjust the height as needed
                color: Colors.white, // You can use any background color here
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget ShimmerMedia() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: double.infinity,
      height: 150, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.white, // You can use any background color here
        borderRadius: BorderRadius.circular(10), // Set the border radius
      ),
    ),
  );
}

Widget NoDataWidget({required String text}) {
  return Container(
    color: AppColors.kcBackgroundColor,
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/no_data.png',
          fit: BoxFit.contain,
          width: 299,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 101),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.kcDescription,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget NoSearchDataWidget() {
  return Container(
    color: AppColors.kcBackgroundColor,
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/no_data_search.png',
          fit: BoxFit.contain,
          width: 250,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            'We can’t find any what you search.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.kcDescription,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ShimmerPhoto() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!, // Warna latar belakang selama shimmer
    highlightColor: Colors.grey[100]!, // Warna kilau selama shimmer
    child: CircleAvatar(
        backgroundColor: AppColors.kcWhitePrimary,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.kcBgPhotoContact,
          child: Container(),
        )),
  );
}

ImageProvider<Object> ImageType(String value) {
  if (value.startsWith('http') || value.startsWith('https')) {
    // It's a URL
    return NetworkImage(value);
  } else {
    // It's a local file path
    return FileImage(File(value));
  }
}

Image ImageContact(String value) {
  if (value.startsWith('http') || value.startsWith('https')) {
    // It's a URL
    return Image.network(
      value,
      fit: BoxFit.fitWidth,
    );
  } else {
    // It's a local file path
    return Image.file(
      fit: BoxFit.fitWidth,
      File(value),
    );
  }
}

Widget MediaType(String mediaPath, String uid, String docsId) {
  if (mediaPath.contains(
      'https://firebasestorage.googleapis.com/v0/b/flubase01.appspot.com/o/${uid}%2Fmedia%2F${docsId}')) {
    if (mediaPath.contains(".jpg") ||
        mediaPath.endsWith(".png") ||
        mediaPath.endsWith(".jpeg")) {
      return ImageTypeMedia(mediaPath);
    }
    return CustomVideoPlayer(videoPath: mediaPath);
  } else {
    if (mediaPath.endsWith(".jpg") ||
        mediaPath.endsWith(".png") ||
        mediaPath.endsWith(".jpeg")) {
      return ImageTypeMedia(mediaPath);
    }
    return CustomVideoPlayer(videoPath: mediaPath);
  }
  // if (mediaPath.endsWith('.jpeg')) {
  //   // print("Media Path Jpeg: $mediaPath");
  //   return ImageTypeMedia(mediaPath);
  // } else if (mediaPath.endsWith('.mp4')) {
  //   // print("Media Path video: $mediaPath");
  //   return CustomVideoPlayer(videoPath: mediaPath);
  // }

  //   // Handle other media types or return a default widget
  return Text('Unsupported media type');
}

Widget ImageTypeMedia(String value) {
  if (value.startsWith('http') || value.startsWith('https')) {
    // It's a URL
    return Image.network(value);
  } else {
    // It's a local file path
    return Image.file(File(value));
  }
}

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath;

  CustomVideoPlayer({required this.videoPath});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  void initState() {
    super.initState();
    _videoPlayerController = widget.videoPath.startsWith('http') ||
            widget.videoPath.startsWith('https') ||
            widget.videoPath
                .startsWith("https://firebasestorage.googleapis.com")
        ? VideoPlayerController.networkUrl(
            Uri.parse(widget.videoPath),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          )
        : VideoPlayerController.file(
            File(widget.videoPath),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          );

    // _videoPlayerController.addListener(() {
    //   setState(() {});
    // });
    _videoPlayerController.setLooping(false);
    _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:  16 /9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), // Border radius
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_videoPlayerController),
            _ControlsOverlay(controller: _videoPlayerController),
            VideoProgressIndicator(_videoPlayerController,
                allowScrubbing: true,
                colors: VideoProgressColors(playedColor: Color(0xff00559E))),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({required this.controller});

  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
           setState(() {
              widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
           });
          },
        ),
      ],
    );
  }
}
