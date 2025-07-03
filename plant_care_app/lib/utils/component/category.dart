import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppCategory extends StatelessWidget {
  const AppCategory({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppStyle.categoryItem,
        Text(category, style: AppStyle.headLine3),
      ],
    );
  }
}
