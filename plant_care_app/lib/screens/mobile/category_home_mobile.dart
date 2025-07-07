import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/screens/mobile/n_m_category_mobile.dart';
import 'package:plant_care_app/styles/app_style.dart';

class CategoryHomeMobile extends StatefulWidget {
  const CategoryHomeMobile({super.key});

  @override
  State<CategoryHomeMobile> createState() => _CategoryHomeMobileState();
}

class _CategoryHomeMobileState extends State<CategoryHomeMobile> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final data = await PlantCareDatabase.instance.getAllCategories();
    setState(() {
      categories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorie')),
      body: Column(
        children: [
          categories.isEmpty
              ? const Center(child: Text('Nessuna categoria presente'))
              : Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(
                      title: Text(category['name']),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CategoryMobileForm(
                                  categoryId: category['id'],
                                ),
                          ),
                        );
                        _loadCategories();
                      },
                    );
                  },
                ),
              ),
          ElevatedButton(
            onPressed:
                () =>
                    Navigator.pushNamed(context, AppRoutes.categoryMobileForm),

            //Navigator.pushNamed(context, '/form'),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                AppStyle.bgButtonPositive,
              ),
            ),
            child: Text('Nuova categoria', style: AppStyle.mobileButton),
          ),
        ],
      ),
    );
  }
}
