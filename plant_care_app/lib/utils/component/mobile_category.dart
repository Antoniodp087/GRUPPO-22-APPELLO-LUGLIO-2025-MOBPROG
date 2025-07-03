import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileAppCategory extends StatelessWidget {
  const MobileAppCategory({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppStyle.categoryItemMobile,
        Text(category, style: AppStyle.mobileHeadLine3),
      ],
    );
  }
}
