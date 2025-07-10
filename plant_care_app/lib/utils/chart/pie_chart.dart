import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:plant_care_app/database/database_sqlite.dart';

class AppPieChart extends StatefulWidget {
  const AppPieChart({super.key});

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
          width: 350,
          height: 700,
          child:
              dataMap.isEmpty
                  ? const Text("Nessuna pianta disponibile.")
                  : PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    chartType: ChartType.ring,
                    centerText: _totalPlants.toString(),
                    chartLegendSpacing: 32,
                    legendOptions: const LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 0,
                    ),
                  ),
        );
  }
}
