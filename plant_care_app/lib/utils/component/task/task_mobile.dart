import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/mobile/n_m_plant_mobile.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';

class MobileTask extends StatefulWidget {
  const MobileTask({super.key});

  @override
  State<MobileTask> createState() => _MobileTaskState();
}

class _MobileTaskState extends State<MobileTask> {
  List<Map<String, dynamic>> watering = [];
  List<Map<String, dynamic>> pruning = [];
  List<Map<String, dynamic>> transfer = [];
  List<Map<String, dynamic>> plants = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    final data = await PlantCareDatabase.instance.getAllPlants();
    setState(() {
      plants = data;
    });
  }

  Future<void> loadTasks() async {
    final db = PlantCareDatabase.instance;
    final upcomingWatering = await db.getUpcomingWaterings();
    final upcomingPruning = await db.getUpcomingPrunings();
    final upcomingTransfer = await db.getUpcomingTransfers();

    setState(() {
      watering = upcomingWatering;
      pruning = upcomingPruning;
      transfer = upcomingTransfer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: Row(
            children: [
              AppStyle.dropletEmojiMobile,
              Text('Annaffiare:', style: AppStyle.mobileHeadLine3),
            ],
          ),
          children:
              watering.isEmpty
                  ? [ListTile(title: Text('Nessuna scadenza'))]
                  : watering
                      .map(
                        (e) => ListTile(
                          title: AppCardMobile(
                            plantName: e['name'],
                            image: NetworkImage(e['image']),
                          ),
                          subtitle: Text(
                            "Scadenza: ${e['watering']} (${e['days_left']} giorni)",
                            style: AppStyle.mobileTextAllert,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MobileForm(plantId: e['id']),
                              ),
                            );
                            _loadPlants();
                          },
                        ),
                      )
                      .toList(),
        ),

        ExpansionTile(
          title: Row(
            children: [
              AppStyle.carpentrySawEmojiMobile,
              Text('Potare:', style: AppStyle.mobileHeadLine3),
            ],
          ),
          children:
              pruning.isEmpty
                  ? [ListTile(title: Text('Nessuna scadenza'))]
                  : pruning
                      .map(
                        (e) => ListTile(
                          title: AppCardMobile(
                            plantName: e['name'],
                            image: NetworkImage(e['image']),
                          ),
                          subtitle: Text(
                            "Scadenza: ${e['pruning']} (${e['days_left']} giorni)",
                            style: AppStyle.mobileTextAllert,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MobileForm(plantId: e['id']),
                              ),
                            );
                            _loadPlants();
                          },
                        ),
                      )
                      .toList(),
        ),
        ExpansionTile(
          title: Row(
            children: [
              AppStyle.pottedPlantEmojiMobile,
              Text('Travasare:', style: AppStyle.mobileHeadLine3),
            ],
          ),
          children:
              transfer.isEmpty
                  ? [ListTile(title: Text('Nessuna scadenza'))]
                  : transfer
                      .map(
                        (e) => ListTile(
                          title: AppCardMobile(
                            plantName: e['name'],
                            image: NetworkImage(e['image']),
                          ),
                          subtitle: Text(
                            "Scadenza: ${e['transfer']} (${e['days_left']} giorni)",
                            style: AppStyle.mobileTextAllert,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MobileForm(plantId: e['id']),
                              ),
                            );
                            _loadPlants();
                          },
                        ),
                      )
                      .toList(),
        ),
      ],
    );
  }
}
