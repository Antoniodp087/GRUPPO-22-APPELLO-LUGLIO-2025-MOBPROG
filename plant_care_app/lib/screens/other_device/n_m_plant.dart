import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/json_exporter.dart';

class AppForm extends StatefulWidget {
  const AppForm({super.key, this.plantId});
  final int? plantId;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  List<Map<String, dynamic>> _categories = [];
  int? selectedCategoryId;
  String? categoryChoice;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController immageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController plantedOnController = TextEditingController();

  String? category;

  final TextEditingController wateringFrequencyController =
      TextEditingController();

  final TextEditingController pruningFrequencyController =
      TextEditingController();
  final TextEditingController transferFrequencyController =
      TextEditingController();

  TextEditingController lastWateringController = TextEditingController();
  TextEditingController lastPruningController = TextEditingController();
  TextEditingController lastTransferController = TextEditingController();

  TextEditingController nextWateringController = TextEditingController();
  TextEditingController nextPruningController = TextEditingController();
  TextEditingController nextTransferController = TextEditingController();

  String? status;

  final TextEditingController noteController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  bool watering = false;
  bool pruning = false;
  bool transfer = false;

  bool isDateEditable = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    if (widget.plantId != null) {
      _loadData(widget.plantId!);
    }
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
      nameController.text = data['name'] ?? "";
      speciesController.text = data['species'] ?? "";
      immageController.text = data['image'] ?? '';
      descriptionController.text = data['description'] ?? "";
      plantedOnController.text = data['planted_on'] ?? "";
      selectedCategoryId = data['category_id'];
      wateringFrequencyController.text = data['watering_frequency'] ?? "";
      pruningFrequencyController.text = data['pruning_frequency'] ?? "";
      transferFrequencyController.text = data['transfer_frequency'] ?? "";
      lastWateringController.text = data['last_watering'] ?? "";
      lastPruningController.text = data['last_pruning'] ?? "";
      lastTransferController.text = data['last_transfer'] ?? "";
      nextWateringController.text = data['next_watering'] ?? "";
      nextPruningController.text = data['next_pruning'] ?? "";
      nextTransferController.text = data['next_transfer'] ?? "";
      status = data['status'];
      noteController.text = data['note'] ?? "";
      isDateEditable = false;
    });
  }

  Future<void> _saveData() async {
    List<String> missingFields = [];

    // 🔍 Validazione centralizzata dei campi

    if (nameController.text.trim().isEmpty) missingFields.add('Nome');
    if (speciesController.text.trim().isEmpty) missingFields.add('Specie');

    if (immageController.text.trim().isEmpty) missingFields.add('URL immagine');

    if (plantedOnController.text.trim().isEmpty)
      missingFields.add('Data di piantagione');

    if (categoryChoice == 'new') {
      final newCategoryName = newCategoryController.text.trim();

      if (newCategoryName.isEmpty) {
        missingFields.add('Nuova categoria');
      } else {
        final alreadyExists = _categories.any(
          (cat) =>
              cat['name'].toString().toLowerCase() ==
              newCategoryName.toLowerCase(),
        );

        if (alreadyExists) {
          await showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Categoria già esistente'),
                  content: Text(
                    'La categoria "$newCategoryName" esiste già. Scegli un nome diverso.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
          return; // blocca il salvataggio
        }
      }
    } else if (selectedCategoryId == null) {
      missingFields.add('Categoria');
    }

    if (wateringFrequencyController.text.trim().isEmpty)
      missingFields.add('Frequenza di annaffiatura');

    if (pruningFrequencyController.text.trim().isEmpty)
      missingFields.add('Frequenza di potatura');

    if (transferFrequencyController.text.trim().isEmpty)
      missingFields.add('Frequenza di travaso');

    if (missingFields.isNotEmpty) {
      await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Campi mancanti'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: missingFields.map((f) => Text('• $f')).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    final formatter = DateFormat('dd/MM/yyyy');
    final today = DateTime.now();
    final todayString = formatter.format(today);
    DateTime plantedDate = formatter.parse(plantedOnController.text);

    DateTime nextWatering = plantedDate.add(Duration(days: 2));
    DateTime nextPruning = plantedDate.add(Duration(days: 60));
    DateTime nextTransfer = plantedDate.add(Duration(days: 365));

    String nextWateringString = formatter.format(nextWatering);
    String nextPruningString = formatter.format(nextPruning);
    String nextTransferString = formatter.format(nextTransfer);

    if (widget.plantId == null) {
      lastWateringController = plantedOnController;
      lastPruningController = plantedOnController;
      lastTransferController = plantedOnController;

      nextWateringController.text = nextWateringString;
      nextPruningController.text = nextPruningString;
      nextTransferController.text = nextTransferString;
    }

    if (widget.plantId != null) {
      if (watering) {
        DateTime d = today;
        nextWatering = d.add(
          Duration(days: int.parse(wateringFrequencyController.text)),
        );
        nextWateringString = formatter.format(nextWatering);
        lastWateringController = nextWateringController;
        nextWateringController.text = nextWateringString;
      }

      if (pruning) {
        DateTime d = today;
        nextPruning = d.add(
          Duration(days: int.parse(pruningFrequencyController.text)),
        );
        nextPruningString = formatter.format(nextPruning);
        lastPruningController = nextPruningController;
        nextPruningController.text = nextPruningString;
      }

      if (transfer) {
        DateTime d = today;
        nextTransfer = d.add(
          Duration(days: int.parse(transferFrequencyController.text)),
        );
        nextTransferString = formatter.format(nextTransfer);
        lastTransferController = nextTransferController;
        nextTransferController.text = nextTransferString;
      }
    }

    int? categoryIdToSave = selectedCategoryId;

    if (categoryChoice == 'new' &&
        newCategoryController.text.trim().isNotEmpty) {
      final name = newCategoryController.text.trim();
      final existing = _categories.firstWhere(
        (cat) => cat['name'].toString().toLowerCase() == name.toLowerCase(),
        orElse: () => {},
      );

      if (existing.isNotEmpty) {
        categoryIdToSave = existing['id'];
      } else {
        categoryIdToSave = await PlantCareDatabase.instance.insertCategory(
          name,
        );
      }
    }

    DateTime? parseGgMmAaaa(String str) {
      try {
        final parts = str.split('/');
        if (parts.length != 3) return null;
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      } catch (_) {
        return null;
      }
    }

    // Calcolo dello status
    int overdueCount = 0;
    final wateringDate = parseGgMmAaaa(nextWateringController.text);
    final pruningDate = parseGgMmAaaa(nextPruningController.text);
    final transferDate = parseGgMmAaaa(nextTransferController.text);

    if (wateringDate != null && wateringDate.isBefore(today)) overdueCount++;
    if (pruningDate != null && pruningDate.isBefore(today)) overdueCount++;
    if (transferDate != null && transferDate.isBefore(today)) overdueCount++;

    String status = switch (overdueCount) {
      >= 2 => 'malata',
      1 => 'da controllare',
      _ => 'sana',
    };

    final data = {
      'name': nameController.text,
      'species': speciesController.text,
      'image': immageController.text,
      'description': descriptionController.text,
      'planted_on': plantedOnController.text,
      'category_id': categoryIdToSave,
      'watering_frequency': wateringFrequencyController.text,
      'pruning_frequency': pruningFrequencyController.text,
      'transfer_frequency': transferFrequencyController.text,
      'last_watering': lastWateringController.text,
      'last_pruning': lastPruningController.text,
      'last_transfer': lastTransferController.text,
      'next_watering': nextWateringController.text,
      'next_pruning': nextPruningController.text,
      'next_transfer': nextTransferController.text,
      'status': status,
      'note': noteController.text,
    };

    // Salvataggio
    if (widget.plantId != null) {
      await PlantCareDatabase.instance.updatePlant(widget.plantId!, data);
    } else {
      await PlantCareDatabase.instance.insertPlant(data);
    }

    // Esporta JSON aggiornato
    await JsonExporter.instance.exportToJson();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(
        () =>
            plantedOnController.text = DateFormat('dd/MM/yyyy').format(picked),
      );
    }
  }

  Future<void> _exit() async {
    if (widget.plantId != null) {
      await PlantCareDatabase.instance.deletePlant(widget.plantId!);
    }
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.plantId != null) {
      title = nameController.text;
    } else {
      title = 'Nuova pianta';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title, style: AppStyle.headLine1)),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(30.0),
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome pianta',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: speciesController,
                  decoration: InputDecoration(
                    labelText: 'Specie',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: immageController,
                  decoration: InputDecoration(
                    labelText: 'Url dell\'immagine',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrizione',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: plantedOnController,
                  decoration: InputDecoration(
                    labelText: 'Piantata il: ',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: isDateEditable ? _pickDate : null,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  value: selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    ..._categories.map((cat) {
                      return DropdownMenuItem<int>(
                        value: cat['id'],
                        child: Text(cat['name']),
                      );
                    }),
                    const DropdownMenuItem<int>(
                      value: -1,
                      child: Text('Altro'),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      if (val == -1) {
                        categoryChoice = 'new';
                        selectedCategoryId = null;
                      } else {
                        categoryChoice = null;
                        selectedCategoryId = val;
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                if (categoryChoice == 'new')
                  TextFormField(
                    controller: newCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Nuova categoria',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 20),
                TextFormField(
                  controller: wateringFrequencyController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Frequenza di annaffiatura in giorni',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: pruningFrequencyController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Frequenza di potatura in giorni',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: transferFrequencyController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Frequenza di travaso in giorn',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                Column(
                  children: [
                    if (widget.plantId != null) ...[
                      CheckboxListTile(
                        value: watering,
                        onChanged: (val) => setState(() => watering = val!),
                        title: const Text('Innaffiata'),
                      ),
                      CheckboxListTile(
                        value: pruning,
                        onChanged: (val) => setState(() => pruning = val!),
                        title: const Text('Potata'),
                      ),
                      CheckboxListTile(
                        value: transfer,
                        onChanged: (val) => setState(() => transfer = val!),
                        title: const Text('Travasata'),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 60),

                ElevatedButton(
                  onPressed: _exit,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonNegative,
                    ),
                  ),
                  child: Text('Elimina', style: AppStyle.button),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _saveData,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonPositive,
                    ),
                  ),
                  child: Text('Salva', style: AppStyle.button),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
