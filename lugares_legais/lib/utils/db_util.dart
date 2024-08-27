import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbUtil {
  static Future<Database> _getDatabase() async {
    final databasesPath = await sql.getDatabasesPath();
    final dbPath = path.join(databasesPath, 'places.db');

    return sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) => db.execute(
          'CREATE TABLE Place (Id INTEGER PRIMARY KEY, Title TEXT, Image TEXT)'),
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await _getDatabase();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await _getDatabase();
    return db.query(table);
  }
}
