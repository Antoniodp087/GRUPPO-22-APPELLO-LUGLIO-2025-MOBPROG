import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AnalysisStatus extends StatelessWidget {
  const AnalysisStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    String generalStatus;
    Text genearlEmoji;
    switch (status) {
      case 'sana':
        {
          generalStatus = "SANO";
          genearlEmoji = AppStyle.analysisSmilingFaceEmoji;
        }

        break;
      case 'da controllare':
        {
          generalStatus = "DA CONTROLLARE";
          genearlEmoji = AppStyle.analysisPensiveEmoji;
        }

        break;
      case 'malata':
        {
          generalStatus = "PESSIMO";
          genearlEmoji = AppStyle.analysisBandedEmoji;
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
