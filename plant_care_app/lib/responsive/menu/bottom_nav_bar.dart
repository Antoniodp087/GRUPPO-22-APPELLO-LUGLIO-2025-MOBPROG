import 'package:flutter/material.dart';
import 'package:plant_care_app/screens/mobile/analysis_mobile.dart';
import 'package:plant_care_app/screens/mobile/category_home_mobile.dart';
import 'package:plant_care_app/screens/mobile/home_mobile.dart';
import 'package:plant_care_app/screens/mobile/plant_detail_mobile.dart';
import 'package:plant_care_app/screens/mobile/search_mobile.dart';
import 'package:plant_care_app/styles/app_style.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //screen
  final appScreens = [
    HomeMobile(),
    CategoryHomeMobile(),
    SearchPageMobile(),
    AnalysisMobile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreens[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppStyle.iconActivated,
        unselectedItemColor: AppStyle.iconUnactivated,
        showSelectedLabels: false,

        //tab changer
        onTap: widget.onTap,
        currentIndex: widget.currentIndex,

        //items of Navigation Bar
        items: [
          BottomNavigationBarItem(
            icon: AppStyle.houseMobile,
            label: 'Home',
            activeIcon: AppStyle.houseMobileActive,
          ),
          BottomNavigationBarItem(
            icon: AppStyle.categoryMobile,
            label: 'Category',
            activeIcon: AppStyle.categoryMobileActive,
          ),
          BottomNavigationBarItem(
            icon: AppStyle.searchMobile,
            label: 'Search',
            activeIcon: AppStyle.searchMobileActive,
          ),
          BottomNavigationBarItem(
            icon: AppStyle.analysisMobile,
            label: 'Analysis',
            activeIcon: AppStyle.analysisMobileActive,
          ),
        ],
      ),
    );
  }
}
