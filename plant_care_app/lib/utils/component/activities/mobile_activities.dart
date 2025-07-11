import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileActivities extends StatelessWidget {
  const MobileActivities({
    super.key,
    this.wateringFrequency,
    this.pruningFrequency,
    this.transferFrequency,

    this.nextWatering,

    this.nextPruning,

    this.nextTransfer,
  });
  final String? wateringFrequency;
  final String? pruningFrequency;
  final String? transferFrequency;

  final String? nextWatering;
  final String? nextPruning;
  final String? nextTransfer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppStyle.dropletEmojiMobile,
            Text("Innaffiare ogni: ", style: AppStyle.mobileHeadLine3),
            Text(wateringFrequency ?? "NaN", style: AppStyle.mobileHeadLine3),
            SizedBox(width: 4),
            Text("giorni", style: AppStyle.mobileHeadLine3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("il : $nextWatering")],
        ),

        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppStyle.carpentrySawEmojiMobile,
            Text("Potare ogni: ", style: AppStyle.mobileHeadLine3),
            Text(pruningFrequency ?? "NaN ", style: AppStyle.mobileHeadLine3),
            SizedBox(width: 4),
            Text("giorni", style: AppStyle.mobileHeadLine3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("il : $nextPruning")],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppStyle.pottedPlantEmojiMobile,
            Text("Travasare ogni: ", style: AppStyle.mobileHeadLine3),
            Text(transferFrequency ?? "NaN ", style: AppStyle.mobileHeadLine3),
            SizedBox(width: 4),
            Text("giorni", style: AppStyle.mobileHeadLine3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("il : $nextTransfer")],
        ),
      ],
    );
  }
}
