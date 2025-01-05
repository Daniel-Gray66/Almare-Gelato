import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gelato_shop.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE stamp_card (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            stamps INTEGER DEFAULT 0
          )
          '''
        );
      },
    );
  }

  Future<int> getStamps() async {
    final db = await database;
    final result = await db.query(
      'stamp_card',
      columns: ['stamps'],
      limit: 1,
    );

    if (result.isEmpty) {
      // Insert initial data if no entry exists
      await db.insert('stamp_card', {'stamps': 0});
      return 0;
    }

    return result.first['stamps'] as int;
  }

  Future<void> addStamp() async {
    final db = await database;

    final currentStamps = await getStamps();
    final newStamps = currentStamps + 1;

    await db.update(
      'stamp_card',
      {'stamps': newStamps},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
