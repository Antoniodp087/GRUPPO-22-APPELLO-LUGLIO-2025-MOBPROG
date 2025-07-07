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

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
