import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileAppDoubleText extends StatelessWidget {
  const MobileAppDoubleText({
    super.key,
    required this.bigText,
    required this.smallText,
  });
  final String bigText;
  final String smallText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(bigText, style: AppStyle.mobileHeadLine0),
        Text(smallText, style: AppStyle.mobileHeadLine1),
      ],
    );
  }
}
