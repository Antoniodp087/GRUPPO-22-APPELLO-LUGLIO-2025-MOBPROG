import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';

class TotalPlant extends StatefulWidget {
  const TotalPlant({super.key});

  @override
  State<TotalPlant> createState() => _TotalPlantState();
}

class _TotalPlantState extends State<TotalPlant> {
  int _totalPlants = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalPlants();
  }

  Future<void> _loadTotalPlants() async {
    final count = await PlantCareDatabase.instance.getTotalPlantCount();
    setState(() {
      _totalPlants = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$_totalPlants', style: AppStyle.analysisTitle));
  }
}
