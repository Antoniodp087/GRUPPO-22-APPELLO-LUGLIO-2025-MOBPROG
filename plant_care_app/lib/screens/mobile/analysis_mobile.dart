import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:plant_care_app/database/database_sqlite.dart';

class AnalysisMobile extends StatefulWidget {
  const AnalysisMobile({super.key});

  @override
  State<AnalysisMobile> createState() => _AnalysisMobileState();
}

class _AnalysisMobileState extends State<AnalysisMobile> {
  int totalPlants = 0;
  Map<String, int> categoryCounts = {};
  List<int> plantsPerMonth = List.filled(12, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = PlantCareDatabase.instance;
    final allPlants = await db.getAllPlants();
    final allCategories = await db.getAllCategories();

    print("🌱 All Plants: $allPlants");
    print("📂 All Categories: $allCategories");

    totalPlants = allPlants.length;

    // Conta piante per categoria
    categoryCounts.clear();
    for (final category in allCategories) {
      final name = category['name'];
      if (name is String) {
        try {
          final count = await db.getPlantCountByCategoryName(name);
          categoryCounts[name] = count;
          debugPrint("✅ Categoria: $name, Count: $count");
        } catch (e, st) {
          debugPrint("❌ Errore per categoria '$name': $e");
          debugPrint("$st");
        }
      } else {
        debugPrint("⚠️ Categoria con nome non valido: $category");
      }
    }

    // Conta piante per mese
    plantsPerMonth = List.filled(12, 0);
    for (final plant in allPlants) {
      final plantedOn = plant['planted_on'] as String?;
      if (plantedOn != null && plantedOn.length == 10) {
        final month = int.tryParse(plantedOn.substring(3, 5));
        if (month != null && month >= 1 && month <= 12) {
          plantsPerMonth[month - 1]++;
        }
      }
    }
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisi delle Piante')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: _buildTotalPlants(),
                    ),
                    const SizedBox(height: 32),
                    //_buildPieChart(),
                    const SizedBox(height: 32),
                    _buildBarChart(),
                  ],
                ),
              ),
    );
  }

  Widget _buildTotalPlants() {
    return Text(
      'Totale piante: $totalPlants',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPieChart() {
    final colors = [
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.red,
      Colors.teal,
      Colors.brown,
      Colors.cyan,
    ];

    final sections =
        categoryCounts.entries.map((entry) {
          final index = categoryCounts.keys.toList().indexOf(entry.key);
          return PieChartSectionData(
            color: colors[index % colors.length],
            value: entry.value.toDouble(),
            title: '${entry.key} (${entry.value})',
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            radius: 60,
          );
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distribuzione per Categoria',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        PieChart(
          PieChartData(
            sections: sections,
            centerSpaceRadius: 40,
            sectionsSpace: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    final months = [
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
    final barGroups = List.generate(12, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: plantsPerMonth[index].toDouble(),
            width: 16,
            color: Colors.green,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Piante piantate per mese',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              maxY: (maxCount + 2).toDouble(),
              barGroups: barGroups,
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
