import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class Status extends StatelessWidget {
  const Status({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    String generalStatus;
    Text genearlEmoji;
    switch (status) {
      case 'sana':
        {
          generalStatus = "SANO";
          genearlEmoji = AppStyle.smilingFaceEmoji;
        }

        break;
      case 'da controllare':
        {
          generalStatus = "DA CONTROLLARE";
          genearlEmoji = AppStyle.pensiveEmoji;
        }

        break;
      case 'malata':
        {
          generalStatus = "PESSIMO";
          genearlEmoji = AppStyle.bandedEmoji;
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
          Text(generalStatus, style: AppStyle.headLine1),
          genearlEmoji,
        ],
      ),
    );
  }
}
