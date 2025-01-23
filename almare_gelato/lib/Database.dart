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
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE stamp_card (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            stamps INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> getStamps() async {
    final db = await database;
    final result = await db.query('stamp_card', columns: ['stamps'], limit: 1);
    if (result.isEmpty) {
      await db.insert('stamp_card', {'stamps': 0});
      return 0;
    }
    return result.first['stamps'] as int;
  }

  Future<void> updateStamps(int newCount) async {
    final db = await database;
    await db.update(
      'stamp_card',
      {'stamps': newCount},
      where: 'id = ?',
      whereArgs: [1], // Assuming only one row for stamps
    );
  }

  Future<void> resetStamps() async {
    await updateStamps(1);
  }

  Future<void> addStamp() async {
    const int maxStamps = 9;
    final int stamps = await getStamps();
    final int newStamps = stamps + 1;

    if (newStamps > maxStamps) {
      await resetStamps();
      print('Card reset after full stamp collection!');
    } else {
      await updateStamps(newStamps);
    }
  }
}
