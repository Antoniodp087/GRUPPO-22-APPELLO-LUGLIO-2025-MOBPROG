import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PlantCareDatabase {
  static final PlantCareDatabase instance = PlantCareDatabase._init();

  static Database? _database;

  PlantCareDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //DATABASE CREATE TABLE
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        species TEXT,
        image TEXT,
        description TEXT,
        planted_on TEXT,
        category_id INTEGER,
        watering_frequency TEXT,
        pruning_frequency TEXT,
        transfer_frequency TEXT,
        last_watering TEXT,
        last_pruning TEXT,
        last_transfer TEXT,
        next_watering TEXT,
        next_pruning TEXT,
        next_transfer TEXT,
        status TEXT,
        note TEXT,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');
    await db.execute("""
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plant_id INTEGER NOT NULL,
        type TEXT NOT NULL, 
        date TEXT NOT NULL,
        FOREIGN KEY (plant_id) REFERENCES plants(id)
      )
    """);
  }

  //DATABASE INSERT ELEMENT
  Future<int> insertPlant(Map<String, dynamic> plant) async {
    final db = await instance.database;
    return await db.insert('plants', plant);
  }

  Future<int> insertCategory(String name) async {
    final db = await instance.database;
    return await db.insert('categories', {
      'name': name,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> insertActivity(int plantId, String type, String date) async {
    final db = await instance.database;
    await db.insert('activities', {
      'plant_id': plantId,
      'type': type,
      'date': date,
    });
  }

  //DATABASE RETURN ELEMENT
  Future<Map<String, dynamic>> getPlant(int id) async {
    final db = await instance.database;
    final maps = await db.query('plants', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    throw Exception('Plant $id not found');
  }

  Future<Map<String, dynamic>> getCategory(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('Category with ID $id not found');
    }
  }

  //DATABASE RETURN ALL ELEMENT
  Future<List<Map<String, dynamic>>> getAllPlants() async {
    final db = await instance.database;
    return await db.query('plants');
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await instance.database;
    return await db.query('categories');
  }

  Future<List<Map<String, dynamic>>> getAllActivities() async {
    final db = await instance.database;
    return await db.query('activities');
  }

  //DATABASE UPDATE ELEMENT
  Future<int> updatePlant(int id, Map<String, dynamic> plant) async {
    final db = await instance.database;
    return await db.update('plants', plant, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCategory(int id, String newName) async {
    final db = await instance.database;
    return await db.update(
      'categories',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //DATABASE DELETE ELEMENT
  Future<int> deletePlant(int id) async {
    final db = await instance.database;
    return await db.delete('plants', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // CATEGORY QUERY
  Future<int> getPlantCountByCategoryName(String categoryName) async {
    final db = await instance.database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(plants.id) as count
      FROM plants
      JOIN categories ON plants.category_id = categories.id
      WHERE categories.name = ?
    ''',
      [categoryName],
    );

    if (result.isNotEmpty && result.first['count'] != null) {
      return Sqflite.firstIntValue(result) ?? 0;
    } else {
      return 0;
    }
  }

  // UPCOMING CARE TASK QUERIES
  Future<List<Map<String, dynamic>>> getUpcomingWaterings() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        id,
        name,
        species,
        image,
        next_watering AS watering,
        CAST(
          julianday(substr(next_watering, 7, 4) || '-' || substr(next_watering, 4, 2) || '-' || substr(next_watering, 1, 2)) 
          - julianday(CURRENT_DATE)
        AS INTEGER) AS days_left
      FROM plants
      WHERE days_left <= watering_frequency
      ORDER BY days_left ASC
    ''');
  }

  Future<List<Map<String, dynamic>>> getUpcomingPrunings() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        id,
        name,
        species,
        image,
        next_pruning AS pruning,
        CAST(
          julianday(substr(next_pruning, 7, 4) || '-' || substr(next_pruning, 4, 2) || '-' || substr(next_pruning, 1, 2)) 
          - julianday(CURRENT_DATE)
        AS INTEGER) AS days_left
      FROM plants
      WHERE days_left <= pruning_frequency
      ORDER BY days_left ASC
    ''');
  }

  Future<List<Map<String, dynamic>>> getUpcomingTransfers() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        id,
        name,
        species,
        image,
        next_transfer AS transfer,
        CAST(
          julianday(substr(next_transfer, 7, 4) || '-' || substr(next_transfer, 4, 2) || '-' || substr(next_transfer, 1, 2)) 
          - julianday(CURRENT_DATE)
        AS INTEGER) AS days_left
      FROM plants
      WHERE days_left <= transfer_frequency
      ORDER BY days_left ASC
    ''');
  }

  //CHART QUERIES
  Future<int> getTotalPlantCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM plants');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getPlantsPerMonth() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT 
      substr(planted_on, 4, 2) AS month,
      COUNT(*) as count
    FROM plants
    WHERE planted_on IS NOT NULL AND planted_on != ''
    GROUP BY month
    ORDER BY month
  ''');
  }

  Future<List<Map<String, dynamic>>> getCareActivitiesByMonth() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT 
      strftime('%m/%Y', date(substr(last_watering, 7, 4) || '-' || substr(last_watering, 4, 2) || '-' || substr(last_watering, 1, 2))) AS month_year,
      COUNT(last_watering) as watering_count,
      COUNT(last_pruning) as pruning_count,
      COUNT(last_transfer) as transfer_count
    FROM plants
    WHERE last_watering IS NOT NULL 
       OR last_pruning IS NOT NULL 
       OR last_transfer IS NOT NULL
    GROUP BY month_year
    ORDER BY month_year ASC
  ''');
  }

  Future<List<Map<String, dynamic>>> getPlantCountByStatus() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT status, COUNT(*) as count
    FROM plants
    GROUP BY status
  ''');
  }

  //CLOSE CONNECTION
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
