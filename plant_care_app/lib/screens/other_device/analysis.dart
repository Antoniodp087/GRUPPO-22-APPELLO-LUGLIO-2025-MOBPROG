import 'package:flutter/material.dart';
import 'package:plant_care_app/styles/app_style.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Overview", style: AppStyle.analysisTitle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TotalPlant(),
                    Text("piante in totale ", style: AppStyle.analysisText),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("di cui :", style: AppStyle.analysisText),
                    AppPieChart(w: 800, h: 300),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("aggiunte per mese", style: AppStyle.analysisText),
                    BarChartPlanted(w: 600, h: 400),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      " Attività svolte per mese",
                      style: AppStyle.analysisText,
                    ),
                    ActivityBarChart(w: 600, h: 400),
                  ],
                ),
              ),
            ],
          ),
          Text("Stato generale: ", style: AppStyle.analysisText),
          SizedBox(height: 10),

          AnalysisStatus(),
        ],
      ),
    );
  }
}
