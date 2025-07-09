import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/other_device/n_m_plant.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/component/activities/activities.dart';
import 'package:plant_care_app/utils/component/category/category.dart';
import 'package:plant_care_app/utils/component/description/description.dart';
import 'package:plant_care_app/utils/component/double_text.dart';
import 'package:plant_care_app/utils/component/status/status.dart';

class PlantDetail extends StatefulWidget {
  const PlantDetail({super.key, required this.plantId});
  final int plantId;

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  List<Map<String, dynamic>> _categories = [];

  String? name;
  String? species;
  String? immage;
  String? description;
  String? plantedOn;
  int? categoryId;
  String? wateringFrequency;
  String? pruningFrequency;
  String? transferFrequency;
  String? lastWatering;
  String? lastPruning;
  String? lastTransfer;
  String? nextWatering;
  String? nextPruning;
  String? nextTransfer;
  String? status;
  String? note;

  String? categoryName;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadData(widget.plantId);
  }

  Future<void> _loadCategories() async {
    final cats = await PlantCareDatabase.instance.getAllCategories();
    setState(() {
      _categories = cats;
    });
  }

  Future<void> _loadData(int id) async {
    final data = await PlantCareDatabase.instance.getPlant(id);
    setState(() {
      name = data['name'] ?? "";
      species = data['species'] ?? "";
      immage = data['image'] ?? '';
      description = data['description'] ?? "";
      plantedOn = data['planted_on'] ?? "";
      categoryId = data['category_id'];
      wateringFrequency = data['watering_frequency'] ?? "";
      pruningFrequency = data['pruning_frequency'] ?? "";
      transferFrequency = data['transfer_frequency'] ?? "";
      lastWatering = data['last_watering'] ?? "";
      lastPruning = data['last_pruning'] ?? "";
      lastTransfer = data['last_transfer'] ?? "";
      nextWatering = data['next_watering'] ?? "";
      nextPruning = data['next_pruning'] ?? "";
      nextTransfer = data['next_transfer'] ?? "";
      status = data['status'];
      note = data['note'] ?? "";
      final category = _categories.firstWhere(
        (cat) => cat['id'] == categoryId,
        orElse: () => {}, // fallback se non trovata
      );

      categoryName = category['name'] ?? 'Categoria sconosciuta';

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text(name!)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppDoubleText(bigText: name!, smallText: species!),
            SizedBox(height: 100),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppDescriptionElement(
                  description: description!,
                  image: NetworkImage(immage!),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Piantata il: ", style: AppStyle.headLine3),
                        Text(plantedOn!, style: AppStyle.headLine3),
                      ],
                    ),
                    AppCategory(category: categoryName!),
                  ],
                ),
                SizedBox(height: 20),
                AppActivities(
                  wateringFrequency: wateringFrequency,
                  pruningFrequency: pruningFrequency,
                  transferFrequency: transferFrequency,
                  nextWatering: nextWatering,
                  nextPruning: nextPruning,
                  nextTransfer: nextTransfer,
                ),
                SizedBox(height: 20),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Note:", style: AppStyle.headLine3),
                        Text(note!, style: AppStyle.headLine3),
                      ],
                    ),
                    Status(status: status!),
                  ],
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppForm(plantId: widget.plantId),
                      ),
                    );

                    if (updated == true) {
                      // Ricarica categorie e dati aggiornati
                      await _loadCategories();
                      await _loadData(widget.plantId);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonNegative,
                    ),
                  ),
                  child: Text('AGGIORNA', style: AppStyle.button),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonPositive,
                    ),
                  ),
                  child: Text('HOME', style: AppStyle.button),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
