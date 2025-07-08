import 'package:flutter/material.dart';
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
      lastWateringController.text = data['last_watering'] ?? "";
      lastPruningController.text = data['last_pruning'] ?? "";
      lastTransferController.text = data['last_transfer'] ?? "";
      nextWateringController.text = data['next_watering'] ?? "";
      nextPruningController.text = data['next_pruning'] ?? "";
      nextTransferController.text = data['next_transfer'] ?? "";
      status = data['status'];
      noteController.text = data['note'] ?? "";
      final tasks = (data['tasks'] ?? '').split(',');
      watering = tasks.contains('car1');
      pruning = tasks.contains('car2');
      transfer = tasks.contains('car3');

      isDateEditable = false;
    });
  }

  Future<void> _saveData() async {
    String dateString = plantedOnController.text;

    final formatter = DateFormat('dd/MM/yyyy');
    final todayString = formatter.format(DateTime.now());

    DateTime originalDate = formatter.parse(dateString);
    DateTime nextWatering = originalDate.add(Duration(days: 2));
    DateTime nextPruning = originalDate.add(Duration(days: 60));
    DateTime nextTransfer = originalDate.add(Duration(days: 365));
    String nextWateringString = formatter.format(nextWatering);
    String nextPruningString = formatter.format(nextPruning);
    String nextTransferString = formatter.format(nextTransfer);

    lastWateringController = plantedOnController;
    lastPruningController = plantedOnController;
    lastTransferController = plantedOnController;
    nextWateringController.text = nextWateringString;
    nextPruningController.text = nextPruningString;
    nextTransferController.text = nextTransferString;

    if (widget.plantId != null) {
      if (watering) {
        dateString = todayString;
        originalDate = formatter.parse(dateString);
        nextWatering = originalDate.add(Duration(days: 2));
        nextWateringString = formatter.format(nextWatering);
        lastWateringController = nextWateringController;
        nextWateringController.text = nextWateringString;
      }
      if (pruning) {
        dateString = todayString;
        originalDate = formatter.parse(dateString);
        nextPruning = originalDate.add(Duration(days: 60));
        nextPruningString = formatter.format(nextPruning);
        lastPruningController = nextPruningController;
        nextPruningController.text = nextPruningString;
      }
      if (transfer) {
        dateString = todayString;
        originalDate = formatter.parse(dateString);
        nextTransfer = originalDate.add(Duration(days: 365));
        nextTransferString = formatter.format(nextTransfer);
        lastTransferController = nextTransferController;
        nextTransferController.text = nextTransferString;
      }
    }

    int? categoryIdToSave = selectedCategoryId;

    if (categoryChoice == 'new' &&
        newCategoryController.text.trim().isNotEmpty) {
      final name = newCategoryController.text.trim();

      // Controlla se già esiste
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

    final data = {
      'name': nameController.text,
      'species': speciesController.text,
      'image': immageController.text,
      'description': descriptionController.text,
      'planted_on': plantedOnController.text,
      'category_id': categoryIdToSave,
      'last_watering': lastWateringController.text,
      'last_pruning': lastPruningController.text,
      'last_transfer': lastTransferController.text,
      'next_watering': nextWateringController.text,
      'next_pruning': nextPruningController.text,
      'next_transfer': nextTransferController.text,
      'status': status,
      'note': noteController.text,
    };

    if (widget.plantId != null) {
      await PlantCareDatabase.instance.updatePlant(widget.plantId!, data);
    } else {
      await PlantCareDatabase.instance.insertPlant(data);
    }

    // Esporta JSON aggiornato
    await JsonExporter.instance.exportToJson();

    if (context.mounted) Navigator.pushReplacementNamed(context, '/');
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
    print('travasata $transfer');
    print('travasata $nextTransferController');
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
                  onChanged: (val) => {setState(() => transfer = val!)},
                  title: const Text('Travasata'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: 'Sano', child: Text('Sano')),
                    DropdownMenuItem(value: 'Malato', child: Text('Malato')),
                    DropdownMenuItem(
                      value: 'Da controllare',
                      child: Text('In crescita'),
                    ),
                  ],
                  onChanged: (val) => setState(() => status = val),
                  decoration: const InputDecoration(
                    labelText: 'Stato',
                    border: OutlineInputBorder(),
                  ),
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
