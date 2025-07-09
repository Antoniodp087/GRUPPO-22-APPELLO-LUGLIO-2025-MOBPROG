import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/mobile/plant_detail_mobile.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';

class MobilePlantList extends StatefulWidget {
  const MobilePlantList({super.key, this.count});
  final int? count;

  @override
  State<MobilePlantList> createState() => _MobilePlantListState();
}

class _MobilePlantListState extends State<MobilePlantList> {
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
      scrollDirection: Axis.vertical,
      itemCount: cont,
      itemBuilder: (context, index) {
        final plant = plants[plants.length - 1 - index];
        return ListTile(
          title: AppCardMobile(
            plantName: plant['name'],
            image: NetworkImage(plant['image']),
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailMobile(plantId: plant['id']),
              ),
            );
            _loadPlants();
          },
        );
      },
    );
  }
}
