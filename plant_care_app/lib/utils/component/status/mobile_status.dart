import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class MobileStatus extends StatelessWidget {
  const MobileStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    String generalStatus;
    Text genearlEmoji;
    switch (status) {
      case 'sana':
        {
          generalStatus = "SANA";
          genearlEmoji = AppStyle.smilingFaceEmojiMobile;
        }

        break;
      case 'da controllare':
        {
          generalStatus = "DA CONTROLLARE";
          genearlEmoji = AppStyle.pensiveEmojiMobile;
        }

        break;
      case 'malata':
        {
          generalStatus = "MALATA";
          genearlEmoji = AppStyle.bandedEmojiMobile;
        }

        break;
      default:
        generalStatus = "INDETERMINATO";
        genearlEmoji = AppStyle.analysisIndeterminateEmoji;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          genearlEmoji,
          SizedBox(height: 10),
          Text(generalStatus, style: AppStyle.mobileHeadLine3),
        ],
      ),
    );
  }
}
