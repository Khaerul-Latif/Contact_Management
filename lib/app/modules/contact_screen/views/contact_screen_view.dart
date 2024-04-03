import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flubase_mobile/app/controllers/auth_controller.dart';
import 'package:flubase_mobile/app/routes/app_pages.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flubase_mobile/utils/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contact_screen_controller.dart';

class ContactScreenView extends GetView<ContactScreenController> {
  ContactScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(" UID pada Contact View : ${controller.uid}");

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
                'Contact',
                style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
              ),
              //  Center(child: ,)
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.SEARCH_CONTACT_SCREEN),
                child: CustomTextFieldSearch(
                  controller: controller.searchC,
                  hintText: 'search name and number',
                  onChanged: (value) {
                    // print('TextField onChanged: $value');
                    // controller.updateSearch(value!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getContact(controller.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: BoxDecoration(
                  color: AppColors.kcBackgroundColor,
                ),
                child: ShimmerList());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return NoDataWidget(text: 'You do not have any contact right now');
          }
          print("docsImage : ${controller.imageUrl.value}");

          var contactsDocs = snapshot.data!.docs;

          return Container(
            decoration: BoxDecoration(
              color: AppColors.kcBackgroundColor,
            ),
            height: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: contactsDocs.length,
              itemBuilder: (context, index) {
                print('Filtered Contacts Length: ${contactsDocs.length}');

                var itemContact =
                    contactsDocs[index].data() as Map<String, dynamic>;
                if (itemContact.containsKey('name') &&
                    itemContact.containsKey('number')) {
                  if (itemContact['name'] != null &&
                      itemContact['number'] != null &&
                      itemContact['name'] != "" &&
                      itemContact['number'] != "") {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kcBgListContact,
                        border: Border.all(
                          color: AppColors.kcBlackPrimary,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        onTap: () async {
                          Get.toNamed(
                            Routes.UPDATE_CONTACT_SCREEN,
                            arguments: {
                              'uid': controller.uid,
                              'docsId': contactsDocs[index].id,
                              'docsImage': await controller.getPhotoContact(
                                controller.uid!,
                                contactsDocs[index].id,
                              ),
                            },
                          );
                        },
                        trailing: IconButton(
                          onPressed: () {
                            controller.deleteContact(
                              contactsDocs[index].id,
                              controller.uid!,
                              context,
                            );
                          },
                          icon: Icon(Icons.delete,
                              color: AppColors.kcBlackPrimary),
                        ),
                        leading: StreamBuilder<String>(
                          stream: controller
                              .getPhotoContact(
                                controller.uid!,
                                contactsDocs[index].id,
                              )
                              .asStream(),
                          builder: (context, photoSnapshot) {
                            if (photoSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ShimmerPhoto();
                            }

                            if (photoSnapshot.hasError) {
                              return Text(
                                  'Error fetching photo: ${photoSnapshot.error}');
                            }

                            controller.imageUrl.value = photoSnapshot.data!;
                            print("image url ${controller.imageUrl.value}");

                            return CircleAvatar(
                                backgroundColor: AppColors.kcWhitePrimary,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage: controller.isNetworkImage(
                                          controller.imageUrl.value)
                                      ? ImageType(controller.imageUrl.value)
                                      : null, // Set backgroundImage to null if not a network image
                                  backgroundColor: controller.isNetworkImage(
                                          controller.imageUrl.value)
                                      ? null
                                      : AppColors.kcBgPhotoContact,
                                  child: controller.isNetworkImage(
                                          controller.imageUrl.value)
                                      ? null
                                      : Center(
                                          child: Text(
                                            itemContact['name'][0]
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: AppColors.kcWhitePrimary,
                                            ),
                                          ),
                                        ),
                                ));
                          },
                        ),
                        title: CustomAppBarAuthText(
                            text: itemContact['name'] ?? ""),
                        subtitle: CustomAppBarAuthText(
                            text: itemContact['number'] ?? ""),
                      ),
                    );
                  } else {
                    // Skip rendering if "name" or "number" is missing or empty
                    return SizedBox.shrink();
                  }
                } else {
                  // Skip rendering if "name" or "number" fields are missing
                  return SizedBox.shrink();
                }
                // }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE_CONTACT_SCREEN);
        },
        backgroundColor: AppColors.kcBgPhotoContact,
        child: Image.asset(
          'assets/icons/create_contact.png',
          height: 24,
          width: 24,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
