import 'package:flutter/material.dart';
import 'package:plant_care_app/screens/all_component.dart';
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
        page = AllComponent();
      //break;
      case 1:
        page = AllComponent();
        ;
      //break;
      case 2:
        page = AllComponent();
        ;
      //break;
      case 3:
        page = AllComponent();
        ;
      //break;
      default:
        throw UnimplementedError('no widget for $currentIndex');
    }

    return Row(
      children: [
        NavigationRail(
          labelType: NavigationRailLabelType.selected,
          useIndicator: false,
          groupAlignment: 0,
          destinations: [
            NavigationRailDestination(
              icon: AppStyle.house,
              label: Text('Home'),
              selectedIcon: AppStyle.houseActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.category,
              label: Text('Category'),
              selectedIcon: AppStyle.categoryActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.search,
              label: Text('Search'),
              selectedIcon: AppStyle.searchActive,
            ),
            NavigationRailDestination(
              icon: AppStyle.analysis,
              label: Text('Analysis'),
              selectedIcon: AppStyle.analysisActive,
            ),
          ],
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
        ),
        Expanded(child: Scaffold(body: Container(child: page))),
      ],
    );
  }
}
