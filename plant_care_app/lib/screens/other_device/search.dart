import 'package:flutter/material.dart';
import 'package:plant_care_app/database/database_sqlite.dart';
import 'package:plant_care_app/screens/other_device/plant_detail.dart';
import 'package:plant_care_app/utils/component/card/card_mobile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> allPlants = [];
  List<Map<String, dynamic>> filteredPlants = [];
  List<Map<String, dynamic>> categories = [];
  String searchQuery = '';
  Set<int> selectedCategoryIds = {};
  Set<String> selectedStatus = {};
  TextEditingController searchController = TextEditingController();

  final List<String> statusOptions = ['sana', 'da controllare', 'malata'];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final plantData = await PlantCareDatabase.instance.getAllPlants();
    final categoryData = await PlantCareDatabase.instance.getAllCategories();

    setState(() {
      allPlants = plantData;
      categories = categoryData;
    });

    filterPlants();
  }

  void filterPlants() {
    setState(() {
      filteredPlants =
          allPlants.where((plant) {
            final nameMatch = plant['name'].toString().toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
            final specieMatch = plant['species']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());

            final matchesSearch =
                searchQuery.isEmpty || nameMatch || specieMatch;

            final matchesCategory =
                selectedCategoryIds.isEmpty ||
                selectedCategoryIds.contains(plant['category_id']);

            final matchesStatus =
                selectedStatus.isEmpty ||
                selectedStatus.contains(
                  plant['status'].toString().toLowerCase(),
                );

            return matchesSearch && matchesCategory && matchesStatus;
          }).toList();
    });
  }

  Widget buildCategoryFilters() {
    return Wrap(
      spacing: 10,
      children:
          categories.map((cat) {
            return FilterChip(
              label: Text(cat['name']),
              selected: selectedCategoryIds.contains(cat['id']),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedCategoryIds.add(cat['id']);
                  } else {
                    selectedCategoryIds.remove(cat['id']);
                  }
                  filterPlants();
                });
              },
            );
          }).toList(),
    );
  }

  Widget buildStatusFilters() {
    return Wrap(
      spacing: 10,
      children:
          statusOptions.map((status) {
            return FilterChip(
              label: Text(status),
              selected: selectedStatus.contains(status),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedStatus.add(status);
                  } else {
                    selectedStatus.remove(status);
                  }
                  filterPlants();
                });
              },
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cerca Piante')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔍 Barra di Ricerca
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Cerca per nome o specie',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filterPlants();
                });
              },
            ),
            const SizedBox(height: 12),
            buildCategoryFilters(),
            const SizedBox(height: 8),
            buildStatusFilters(),
            const SizedBox(height: 12),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    filteredPlants.isEmpty
                        ? const Center(child: Text('Nessuna pianta trovata'))
                        : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    300, // larghezza massima per card
                                mainAxisExtent: 150, // altezza massima per card
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                          itemCount: filteredPlants.length,
                          itemBuilder: (context, index) {
                            final plant = filteredPlants[index];
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            PlantDetail(plantId: plant['id']),
                                  ),
                                );
                              },
                              child: AppCardMobile(
                                plantName: plant['name'],
                                image: NetworkImage(plant['image']),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
