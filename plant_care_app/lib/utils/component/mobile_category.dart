import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileAppCategory extends StatelessWidget {
  const MobileAppCategory({super.key, required this.category, this.number});
  final String category;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppStyle.categoryItemMobile,
          InkWell(
            child: Text(category, style: AppStyle.mobileHeadLine3),
            onTap: () {
              print('$category tapped');
            },
          ),
          SizedBox(width: 5),
          number != null
              ? Text("$number", style: AppStyle.cardMobile)
              : const SizedBox(),
        ],
      ),
    );
  }
}
