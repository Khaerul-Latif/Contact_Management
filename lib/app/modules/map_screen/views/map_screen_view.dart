import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../controllers/map_screen_controller.dart';

class MapScreenView extends GetView<MapScreenController> {
  Location location = Location();
  double latitude = 0.0;
  double longitude = 0.0;
  GoogleMapController? mapController; // Perbarui tipe menjadi nullable
  Set<Marker> markers = Set();

  // Method untuk mendapatkan lokasi saat ini
  Future<void> getCurrentLocation() async {
    var currentLocation = await location.getLocation();
    latitude = currentLocation.latitude!;
    longitude = currentLocation.longitude!;
  }

  // Method untuk menambahkan marker ke peta
  void addMarker() {
    markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: 'Lokasi Saya',
          snippet: 'Deskripsi Lokasi',
        ),
      ),
    );
  }

  // Method untuk menetapkan marker ke peta

  MapScreenView({Key? key}) : super(key: key);
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            textAlign: TextAlign.start,
            'Map',
            style: TextStyle(color: AppColors.kcPrimary, fontSize: 20),
          ),
        ),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  controller.actionMap();
                },
                icon: controller.isActive.value == true
                    ? Icon(color: AppColors.kcBlackPrimary, Icons.location_on)
                    : Icon(
                        color: AppColors.kcBlackPrimary,
                        Icons.location_off,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isActive.value == true
            ? GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 15.0,
                ),
                onMapCreated: (GoogleMapController controller) async {
                  mapController = controller;

                  // Mendapatkan lokasi saat ini
                  await getCurrentLocation();

                  // Menambahkan marker ke peta
                  addMarker();

                  // Menetapkan marker ke peta
                },
                markers: controller.markers,
              )
            : Container(
                // alignment: AlignMne,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.kcBackgroundColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/noactive_map.png',
                        width: 172,
                        height: 172,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "To use this feature, please enable the GPS on your device.",
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
                ),
              ),
      ),
    );
  }
}
