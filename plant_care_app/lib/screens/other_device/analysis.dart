import 'package:flutter/material.dart';
import 'package:plant_care_app/utils/chart/bar_chart_activities.dart';
import 'package:plant_care_app/utils/chart/bar_chart_planted.dart';
import 'package:plant_care_app/utils/chart/pie_chart.dart';
import 'package:plant_care_app/utils/chart/total_plant.dart';
import 'package:plant_care_app/utils/component/status/analysis_status.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TotalPlant(),
          Container(height: 600, width: 600, child: AppPieChart()),
          BarChartPlanted(),

          AnalysisStatus(),
        ],
      ),
    );
  }
}
