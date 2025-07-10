import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartPlanted extends StatefulWidget {
  const BarChartPlanted({super.key});

  @override
  State<BarChartPlanted> createState() => _AppBarChartState();
}

class _AppBarChartState extends State<BarChartPlanted> {
  List<BarChartGroupData> _barGroups = [];
  List<int> plantsPerMonth = List.filled(12, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await PlantCareDatabase.instance.getPlantsPerMonth();
    List<BarChartGroupData> groups = [];

    for (var entry in data) {
      int month = int.tryParse(entry['month'] ?? '0') ?? 0;
      int count = entry['count'] ?? 0;

      groups.add(
        BarChartGroupData(
          x: month,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.green,
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    setState(() {
      _barGroups = groups;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'Gen',
      'Feb',
      'Mar',
      'Apr',
      'Mag',
      'Giu',
      'Lug',
      'Ago',
      'Set',
      'Ott',
      'Nov',
      'Dic',
    ];
    final maxCount = plantsPerMonth.reduce((a, b) => a > b ? a : b);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Piante piantate per mese',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              width: 400,
              child: BarChart(
                BarChartData(
                  maxY: (maxCount + 2).toDouble(),
                  barGroups: _barGroups,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          final int index = value.toInt();
                          return SideTitleWidget(
                            meta: meta,
                            space: 6,
                            child: Text(
                              (index >= 0 && index < months.length)
                                  ? months[index]
                                  : '',
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        );
  }
}
