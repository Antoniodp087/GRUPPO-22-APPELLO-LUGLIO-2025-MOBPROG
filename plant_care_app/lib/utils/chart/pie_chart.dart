import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';

class AppPieChart extends StatefulWidget {
  const AppPieChart({super.key, this.w, this.h});
  final double? w;
  final double? h;

  @override
  State<AppPieChart> createState() => _AppPieChartState();
}

class _AppPieChartState extends State<AppPieChart> {
  Map<String, double> dataMap = {};
  int _totalPlants = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = PlantCareDatabase.instance;

    final categories = await db.getAllCategories();
    final Map<String, double> tempDataMap = {};

    for (var category in categories) {
      final name = category['name'] as String;
      final count = await db.getPlantCountByCategoryName(name);
      if (count > 0) {
        tempDataMap[name] = count.toDouble();
      }
    }

    final count = await PlantCareDatabase.instance.getTotalPlantCount();

    setState(() {
      dataMap = tempDataMap;
      _totalPlants = count;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
          width: widget.w ?? 370,
          height: widget.h ?? 700,
          child:
              dataMap.isEmpty
                  ? const Text("Nessuna pianta disponibile.")
                  : PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    chartType: ChartType.ring,
                    centerText: _totalPlants.toString(),
                    centerTextStyle: AppStyle.analysisTitle,
                    chartLegendSpacing: 32,
                    legendOptions: const LegendOptions(
                      legendTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      chartValueStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      showChartValuesInPercentage: true,
                      showChartValueBackground: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 0,
                    ),
                  ),
        );
  }
}
