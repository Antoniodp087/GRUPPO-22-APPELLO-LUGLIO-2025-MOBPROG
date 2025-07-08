import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/mobile/n_m_plant_mobile.dart';
import 'package:plant_care_app/utils/component/card/card.dart';

class PlantList extends StatefulWidget {
  const PlantList({super.key, this.count});
  final int? count;

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
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
  }

  @override
  Widget build(BuildContext context) {
    final int cont = widget.count ?? plants.length;

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: cont,
      itemBuilder: (context, index) {
        final reverseIndex = plants.length - 1 - index;
        final plant = plants[reverseIndex];
        return Container(
          width: 900,
          child: ListTile(
            title: AppCard(
              plantName: plant['name'],
              plantType: plant['species'],
              image: NetworkImage(plant['image']),
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MobileForm(plantId: plant['id']),
                ),
              );
              _loadPlants();
            },
          ),
        );
      },
    );
  }
}
