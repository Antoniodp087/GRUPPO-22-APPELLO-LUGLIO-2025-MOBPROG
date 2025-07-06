import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:plant_care_app/database/database_sqlite.dart';

class JsonExporter {
  static final JsonExporter instance = JsonExporter._init();
  JsonExporter._init();

  Future<void> exportToJson() async {
    final plants = await PlantCareDatabase.instance.getAllPlants();

    final jsonString = jsonEncode(plants);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/plants.json');

    await file.writeAsString(jsonString);
    print('JSON aggiornato in: ${file.path}');
  }

  Future<String> getJsonPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/plants.json';
  }
}
