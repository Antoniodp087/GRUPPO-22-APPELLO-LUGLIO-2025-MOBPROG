import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartPlanted extends StatefulWidget {
  const BarChartPlanted({super.key, this.w, this.h});
  final double? w;
  final double? h;

  @override
  State<BarChartPlanted> createState() => _BarChartPlantedState();
}

class _BarChartPlantedState extends State<BarChartPlanted> {
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

    // Reset count
    plantsPerMonth = List.filled(12, 0);

    for (var entry in data) {
      int rawMonth = int.tryParse(entry['month'] ?? '0') ?? 0;
      int monthIndex = rawMonth - 1; // da 1-12 a 0-11
      int count = entry['count'] ?? 0;

      if (monthIndex >= 0 && monthIndex < 12) {
        plantsPerMonth[monthIndex] = count;

        groups.add(
          BarChartGroupData(
            x: monthIndex,
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
        : SizedBox(
          width: widget.w ?? 370,
          height: widget.h ?? 700,
          child: Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                  ),
                ),
                maxY: (maxCount + 1).toDouble(),
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
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        );
  }
}
