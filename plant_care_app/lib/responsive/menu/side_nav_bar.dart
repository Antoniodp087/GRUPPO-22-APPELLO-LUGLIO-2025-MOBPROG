import 'package:flutter/material.dart';
import 'package:plant_care_app/screens/all_component.dart';
import 'package:plant_care_app/screens/other_device/analysis.dart';
import 'package:plant_care_app/screens/other_device/category_home.dart';
import 'package:plant_care_app/screens/other_device/home.dart';
import 'package:plant_care_app/screens/other_device/search.dart';
import 'package:plant_care_app/styles/app_style.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    //change page
    Widget page;
    switch (currentIndex) {
      case 0:
        page = Home();
      //break;
      case 1:
        page = CategoryHome();
      //break;
      case 2:
        page = SearchPage();
      //break;
      case 3:
        page = Analysis();
      //break;
      default:
        throw UnimplementedError('no widget for $currentIndex');
    }

    return Row(
      children: [
        NavigationRail(
          labelType: NavigationRailLabelType.selected,
          useIndicator: false,
          groupAlignment: -1,
          destinations: [
            NavigationRailDestination(
              icon: AppStyle.house,
              label: Text('Home', style: AppStyle.headLine3),
              selectedIcon: AppStyle.houseActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.category,
              label: Text('Category', style: AppStyle.headLine3),
              selectedIcon: AppStyle.categoryActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.search,
              label: Text('Search', style: AppStyle.headLine3),
              selectedIcon: AppStyle.searchActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.analysis,
              label: Text('Analysis', style: AppStyle.headLine3),
              selectedIcon: AppStyle.analysisActive,
            ),
          ],
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
        ),
        //content
        Expanded(child: Scaffold(body: Container(child: page))),
      ],
    );
  }
}
