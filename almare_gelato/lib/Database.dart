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
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE stamp_card (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            stamps INTEGER DEFAULT 0,
            stamp_colors TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE stamp_card ADD COLUMN stamp_colors TEXT');
        }
      },
    );
  }

  // ... existing imports and start of class ...

  Future<Map<String, dynamic>> getStampData() async {
    final db = await database;
    final result = await db.query('stamp_card', columns: ['stamps', 'stamp_colors'], limit: 1);
    if (result.isEmpty) {
      const initialColors = '[]';
      await db.insert('stamp_card', {
        'stamps': 0,
        'stamp_colors': initialColors,
      });
      return {'stamps': 0, 'colors': initialColors};
    }
    
    // Add null checking here
    final stampColors = result.first['stamp_colors'] as String?;
    return {
      'stamps': result.first['stamps'] as int? ?? 0,
      'colors': stampColors ?? '[]',
    };
  }

  Future<void> updateStampData(int newCount, String colors) async {
    final db = await database;
    // First check if any records exist
    final result = await db.query('stamp_card', limit: 1);
    
    if (result.isEmpty) {
      // If no record exists, insert one
      await db.insert('stamp_card', {
        'stamps': newCount,
        'stamp_colors': colors,
      });
    } else {
      // Update existing record
      await db.update(
        'stamp_card',
        {
          'stamps': newCount,
          'stamp_colors': colors,
        },
        where: 'id = ?',
        whereArgs: [result.first['id']],
      );
    }
  }

  Future<void> resetStamps() async {
    await updateStampData(0, '[]');  // Changed to start from 0
  }

  Future<void> addStamp() async {
    const int maxStamps = 9;
    final stampData = await getStampData();
    final int currentStamps = stampData['stamps'] as int;
    final int newStamps = currentStamps + 1;

    if (newStamps > maxStamps) {
      await resetStamps();
      print('Card reset after full stamp collection!');
    } else {
      await updateStampData(newStamps, stampData['colors'] as String);
    }
  }

}