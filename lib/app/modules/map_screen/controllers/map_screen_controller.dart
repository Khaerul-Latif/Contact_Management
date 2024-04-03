import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreenController extends GetxController {
  //TODO: Implement MapScreenController
  Location location = Location();
  double latitude = 0.0;
  double longitude = 0.0;
  late GoogleMapController mapController;
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
  /*void setMarkers() {
    mapController.addMarkers(markers);
  }*/

  final isActive = true.obs;
  Future<void> toggleGPS() async {
    var status = await Permission.location;
    if (isActive.value) {
      // Menonaktifkan GPS
      location.serviceEnabled().then((value) {
        if (value) {
          // Mengaktifkan GPS
          location.requestService();
        }
      });
    } else {
      // Mengaktifkan GPS
      location.requestService();
    }

    // Update status GPS
    isActive.toggle();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  actionMap() => isActive.value = !isActive.value;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
