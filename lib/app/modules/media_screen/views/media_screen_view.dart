import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/media_screen_controller.dart';

class MediaScreenView extends GetView<MediaScreenController> {
  MediaScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(" UID pada Media View : ${controller.uid}");
    bool noDataPrinted = false;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.justify,
                'Media',
                style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.SEARCH_MEDIA_SCREEN),
                child: CustomTextFieldSearch(
                  hintText: 'seacrh title',
                  controller: controller.searchC,
                  onChanged: (query) {},
                ),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getMedia(controller.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.kcBackgroundColor,
              ),
              child: ShimmerListMedia(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs == null ||
              snapshot.data!.docs.isEmpty) {
            return NoDataWidget(text: 'You do not have any contact right now');
          }

          var mediaDocs = snapshot.data!.docs;

          return Container(
            decoration: BoxDecoration(
              color: AppColors.kcBackgroundColor,
            ),
            height: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mediaDocs.length,
              itemBuilder: (BuildContext context, int index) {
                var itemMedia = mediaDocs[index].data() as Map<String, dynamic>;
                if (itemMedia.containsKey('title') &&
                    itemMedia.containsKey('description')) {
                  if (itemMedia['title'] != null &&
                      itemMedia['title'] != "" &&
                      itemMedia['description'] != null &&
                      itemMedia['description'] != "") {
                    print("Title : ${itemMedia['title']}");

                    noDataPrinted = false;
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_MEDIA_SCREEN);
                      },
                      child: CustomerContentMedia(
                          onPressed: () {
                            CustomShowBottomDialog(
                              context: context,
                              onPressedUpdate: () {
                                Get.toNamed(Routes.UPDATE_MEDIA_SCREEN);
                              },
                              onPressedDelete: () {
                                Get.back();
                                controller.deleteMedia(
                                  mediaDocs[index].id,
                                  controller.uid!,
                                  context,
                                );
                              },
                            );
                          },
                          title: itemMedia['title'],
                          media: StreamBuilder<String>(
                            stream: controller
                                .getContentMedia(
                                  controller.uid!,
                                  mediaDocs[index].id,
                                )
                                .asStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ShimmerMedia();
                              }

                              controller.mediaUrl.value = snapshot.data!;

                              print(
                                "Download URL : ${controller.mediaUrl.value}",
                              );

                              return controller.mediaUrl.value == ""
                                  ? Obx(() => MediaType(
                                        controller.mediaUrl.value,
                                        controller.uid!,
                                        mediaDocs[index].id,
                                      ))
                                  : MediaType(
                                      controller.mediaUrl.value,
                                      controller.uid!,
                                      mediaDocs[index].id,
                                    );
                            },
                          )),
                    );
                  }
                }
                if (!noDataPrinted) {
                  noDataPrinted = true; // Setel noDataPrinted menjadi true
                  return NoDataWidget(
                    text: 'You do not have any contact right now',
                  );
                }
                return Container();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_MEDIA_SCREEN);
        },
        backgroundColor: AppColors.kcBgPhotoContact,
        child: Image.asset(
          'assets/icons/create_media.png',
          height: 24,
          width: 24,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
