import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/routes/app_routes.dart';
import 'package:plant_care_app/screens/other_device/n_m_category.dart';
import 'package:plant_care_app/styles/app_style.dart';
import 'package:plant_care_app/utils/component/category/category.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({super.key});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  List<Map<String, dynamic>> categories = [];
  Map<int, int> categoryCounts = {}; // id categoria -> numero piante

  @override
  void initState() {
    super.initState();
    _loadCategoriesAndCounts();
  }

  Future<void> _loadCategoriesAndCounts() async {
    final data = await PlantCareDatabase.instance.getAllCategories();

    final Map<int, int> counts = {};
    for (var category in data) {
      final count = await PlantCareDatabase.instance
          .getPlantCountByCategoryName(category['name']);
      counts[category['id']] = count;
    }

    setState(() {
      categories = data;
      categoryCounts = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.00),
        child: Column(
          children: [
            categories.isEmpty
                ? const Expanded(
                  child: Center(child: Text('Nessuna categoria presente')),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final num = categoryCounts[category['id']] ?? 0;

                      return ListTile(
                        title: AppCategory(
                          category: category['name'],
                          number: num,
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      CategoryForm(categoryId: category['id']),
                            ),
                          );
                          await _loadCategoriesAndCounts();
                        },
                      );
                    },
                  ),
                ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, AppRoutes.categoryForm);
                await _loadCategoriesAndCounts();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  AppStyle.bgButtonPositive,
                ),
              ),
              child: Text('Nuova categoria', style: AppStyle.button),
            ),
          ],
        ),
      ),
    );
  }
}
