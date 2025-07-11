import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/json_exporter.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key, this.categoryId});
  final int? categoryId;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
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

    if (context.mounted) Navigator.pop(context);
  }

  Future<void> _exit() async {
    if (widget.categoryId != null) {
      await PlantCareDatabase.instance.deleteCategory(widget.categoryId!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.categoryId != null) {
      title = nameController.text;
    } else {
      title = 'Nuova categoria';
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 400,
                height: 300,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  AppStyle.bgButtonNegative,
                ),
              ),
              child: Text('Annulla', style: AppStyle.button),
            ),

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
    );
  }
}
