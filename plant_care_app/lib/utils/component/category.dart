import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppCategory extends StatelessWidget {
  const AppCategory({super.key, required this.category, this.number});
  final String category;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppStyle.categoryItem,
        Text(category, style: AppStyle.headLine3),
        SizedBox(width: 5),
        number != null
            ? Text("$number", style: AppStyle.cardSubTitle)
            : const SizedBox(),
      ],
    );
  }
}
