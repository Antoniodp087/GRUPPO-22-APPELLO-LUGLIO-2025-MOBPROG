import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/json_exporter.dart';

class MobileForm extends StatefulWidget {
  const MobileForm({super.key, this.plantId});
  final int? plantId;

  @override
  State<MobileForm> createState() => _MobileFormState();
}

class _MobileFormState extends State<MobileForm> {
  List<Map<String, dynamic>> _categories = [];
  int? selectedCategoryId;
  String? categoryChoice;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController plantedOnController = TextEditingController();

  String? category;

  final TextEditingController lastWateringController = TextEditingController();
  final TextEditingController lastPruningController = TextEditingController();
  final TextEditingController lastTransferController = TextEditingController();

  final TextEditingController nextWateringController = TextEditingController();
  final TextEditingController nextPruningController = TextEditingController();
  final TextEditingController nextTransferController = TextEditingController();

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
    if (widget.plantId != null) {
      _loadCategories();
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
      descriptionController.text = data['description'] ?? "";
      plantedOnController.text = data['planted_on'] ?? "";
      selectedCategoryId = data['category'];
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
    final tasks = [
      if (watering) 'car1',
      if (pruning) 'car2',
      if (transfer) 'car3',
    ].join(',');

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
      'description': descriptionController.text,
      'planted_on': plantedOnController.text,
      'category': categoryIdToSave,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nuova pianta', style: AppStyle.mobileHeadLine1),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome pianta'),
                ),
                TextFormField(
                  controller: speciesController,
                  decoration: InputDecoration(labelText: 'Specie'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Descrizione'),
                ),
                TextFormField(
                  controller: plantedOnController,
                  decoration: InputDecoration(labelText: 'Piantata il: '),
                  readOnly: true,
                  onTap: isDateEditable ? _pickDate : null,
                ),
                DropdownButtonFormField<int>(
                  value: selectedCategoryId,
                  decoration: const InputDecoration(labelText: 'Categoria'),
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
                if (categoryChoice == 'new')
                  TextFormField(
                    controller: newCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Nuova categoria',
                    ),
                  ),

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
                  decoration: const InputDecoration(labelText: 'Stato'),
                ),

                TextFormField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: 'Note'),
                ),

                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonNegative,
                    ),
                  ),
                  child: Text('Elimina', style: AppStyle.mobileButton),
                ),

                ElevatedButton(
                  onPressed: _saveData,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AppStyle.bgButtonPositive,
                    ),
                  ),
                  child: Text('Salva', style: AppStyle.mobileButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
