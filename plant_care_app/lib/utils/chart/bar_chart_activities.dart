import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_care_app/database/database_sqlite.dart';

class ActivityBarChart extends StatefulWidget {
  const ActivityBarChart({super.key});

  @override
  State<ActivityBarChart> createState() => _ActivityBarChartState();
}

class _ActivityBarChartState extends State<ActivityBarChart> {
  Map<String, List<int>> activityCounts = {
    'watering': List.filled(12, 0),
    'pruning': List.filled(12, 0),
    'transfer': List.filled(12, 0),
  };

  @override
  void initState() {
    super.initState();
    _loadActivityData();
  }

  Future<void> _loadActivityData() async {
    final raw = await PlantCareDatabase.instance.getAllActivities();
    final formatter = DateFormat('dd/MM/yyyy');

    for (final entry in raw) {
      final type = entry['type'];
      final date = formatter.parse(entry['date']);
      final month = date.month - 1;
      if (activityCounts.containsKey(type)) {
        activityCounts[type]![month]++;
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            maxY: _getMaxY(),
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(sideTitles: _bottomTitles()),
              leftTitles: AxisTitles(sideTitles: _leftTitles()),
            ),
            borderData: FlBorderData(show: false),
            barGroups: _buildBarGroups(),
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }

  double _getMaxY() {
    final allValues = [
      ...activityCounts['watering']!,
      ...activityCounts['pruning']!,
      ...activityCounts['transfer']!,
    ];
    return (allValues.reduce((a, b) => a > b ? a : b) + 1).toDouble();
  }

  List<BarChartGroupData> _buildBarGroups() {
    final List<BarChartGroupData> groups = [];

    for (int i = 0; i < 12; i++) {
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: activityCounts['watering']![i].toDouble(),
              color: Colors.blue,
              width: 6,
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: activityCounts['pruning']![i].toDouble(),
              color: Colors.green,
              width: 6,
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: activityCounts['transfer']![i].toDouble(),
              color: Colors.orange,
              width: 6,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
          barsSpace: 4,
        ),
      );
    }

    return groups;
  }

  SideTitles _bottomTitles() {
    const months = [
      'GEN',
      'FEB',
      'MAR',
      'APR',
      'MAG',
      'GIU',
      'LUG',
      'AGO',
      'SET',
      'OTT',
      'NOV',
      'DIC',
    ];
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        final index = value.toInt();
        return SideTitleWidget(
          meta: meta,
          child: Text(
            months[index],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        );
      },
      interval: 1,
      reservedSize: 28,
    );
  }

  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return SideTitleWidget(
          meta: meta,
          child: Text(
            value.toInt().toString(),
            style: const TextStyle(fontSize: 10),
          ),
        );
      },
      interval: 1,
      reservedSize: 32,
    );
  }
}
