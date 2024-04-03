import 'package:flubase_mobile/app/modules/account_screen/views/account_screen_view.dart';
import 'package:flubase_mobile/app/modules/contact_screen/views/contact_screen_view.dart';
import 'package:flubase_mobile/app/modules/map_screen/views/map_screen_view.dart';
import 'package:flubase_mobile/app/modules/media_screen/views/media_screen_view.dart';
import 'package:flubase_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    MapScreenView(),
    ContactScreenView(),
    MediaScreenView(),
    AccountScreenView()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        useLegacyColorScheme: false,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.kcPrimary,
        unselectedItemColor: AppColors.kcNoActiveBottomNavigator,
        iconSize: 24,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/noactive_map.png',
            ),
            activeIcon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/active_map.png',
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/noactive_contact.png',
            ),
            activeIcon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/active_contact.png',
            ),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/noactive_media.png',
            ),
            activeIcon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/active_media.png',
            ),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/noactive_account.png',
            ),
            activeIcon: Image.asset(
              height: 24,
              width: 24,
              'assets/icons/active_account.png',
            ),
            label: 'Account',
          ),
        ],
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        selectedLabelStyle: TextStyle(
          color: AppColors.kcPrimary, // Warna teks saat dipilih
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors
              .kcNoActiveBottomNavigator, // Warna teks saat tidak dipilih
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
