import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/mobile/n_m_plant_mobile.dart';

class PlantListPage extends StatefulWidget {
  const PlantListPage({super.key});

  @override
  State<PlantListPage> createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {
  List<Map<String, dynamic>> plants = [];

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    final data = await PlantCareDatabase.instance.getAllPlants();
    setState(() {
      plants = data;
    });
    print(plants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista Piante')),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return ListTile(
            title: Text(plant['name'] ?? 'Sconosciuto'),
            subtitle: Text(plant['species'] ?? ''),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MobileForm(plantId: plant['id']),
                ),
              );
              _loadPlants();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MobileForm()),
          );
          _loadPlants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
