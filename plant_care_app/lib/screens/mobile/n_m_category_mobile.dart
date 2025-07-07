import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/json_exporter.dart';

class CategoryMobileForm extends StatefulWidget {
  const CategoryMobileForm({super.key, this.categoryId});
  final int? categoryId;

  @override
  State<CategoryMobileForm> createState() => _CategoryMobileFormState();
}

class _CategoryMobileFormState extends State<CategoryMobileForm> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      _loadData(widget.categoryId!);
    }
  }

  Future<void> _loadData(int id) async {
    final data = await PlantCareDatabase.instance.getCategory(id);
    setState(() {
      nameController.text = data['name'] ?? "";
    });
  }

  Future<void> _saveData() async {
    final data = nameController.text;

    if (widget.categoryId != null) {
      await PlantCareDatabase.instance.updateCategory(widget.categoryId!, data);
    } else {
      await PlantCareDatabase.instance.insertCategory(data);
    }

    // Esporta JSON aggiornato
    await JsonExporter.instance.exportToJson();

    if (context.mounted) Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Nuova categoria')),
        body: Column(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Categoria'),
                ),
              ),
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
    );
  }
}
