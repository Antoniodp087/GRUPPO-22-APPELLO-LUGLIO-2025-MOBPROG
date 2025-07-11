import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/chart/bar_chart_activities.dart';
import 'package:plant_care_app/utils/chart/bar_chart_planted.dart';
import 'package:plant_care_app/utils/chart/pie_chart.dart';
import 'package:plant_care_app/utils/chart/total_plant.dart';
import 'package:plant_care_app/utils/component/status/analysis_status.dart';

class AnalysisMobile extends StatelessWidget {
  const AnalysisMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Overview", style: AppStyle.analysisTitle),
            TotalPlant(),
            Text("piante in totale ", style: AppStyle.analysisText),
            SizedBox(height: 10),
            Text("di cui :", style: AppStyle.analysisText),
            AppPieChart(w: 400, h: 250),
            Text("aggiunte per mese", style: AppStyle.analysisText),
            BarChartPlanted(w: 400, h: 600),
            Text(" Attività svolte per mese", style: AppStyle.analysisText),
            ActivityBarChart(w: 400, h: 600),
            Text("Stato generale: ", style: AppStyle.analysisText),
            AnalysisStatus(),
          ],
        ),
      ),
    );
  }
}
