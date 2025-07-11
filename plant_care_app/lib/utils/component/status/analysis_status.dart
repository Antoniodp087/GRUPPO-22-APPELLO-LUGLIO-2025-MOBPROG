import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AnalysisStatus extends StatefulWidget {
  const AnalysisStatus({super.key});

  @override
  State<AnalysisStatus> createState() => _AnalysisStatusState();
}

class _AnalysisStatusState extends State<AnalysisStatus> {
  String generalStatus = 'Indeterminato';

  @override
  void initState() {
    super.initState();
    _generateStatus();
  }

  Future<void> _generateStatus() async {
    final totalCount = await PlantCareDatabase.instance.getTotalPlantCount();
    if (totalCount == 0) return;

    final statusCounts =
        await PlantCareDatabase.instance.getPlantCountByStatus();

    for (final status in statusCounts) {
      final count = status['count'] as int;
      final percentage = (count / totalCount) * 100;
      if (percentage >= 35.0) {
        setState(() => generalStatus = status['status'] ?? 'Indeterminata');
        return;
      }
    }

    setState(() => generalStatus = 'Indeterminata');
  }

  @override
  Widget build(BuildContext context) {
    String status;
    Text genearlEmoji;
    switch (generalStatus) {
      case 'sana':
        {
          status = "SANO";
          genearlEmoji = AppStyle.analysisSmilingFaceEmoji;
        }

        break;
      case 'da controllare':
        {
          status = "DA CONTROLLARE";
          genearlEmoji = AppStyle.analysisPensiveEmoji;
        }

        break;
      case 'malata':
        {
          status = "PESSIMO";
          genearlEmoji = AppStyle.analysisBandedEmoji;
        }

        break;
      default:
        status = "INDETERMINATO";
        genearlEmoji = AppStyle.analysisIndeterminateEmoji;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [genearlEmoji, Text(status, style: AppStyle.analysisTitle)],
      ),
    );
  }
}
