import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtils {
  static Future<sql.Database> database() async {
    final dbpth = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpth, 'places.db'),
        onCreate: (db, version) {
      return db.execute('''
    CREATE TABLE places (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  image TEXT NOT NULL,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  address TEXT NOT NULL
  ''');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtils.database();
    await db.insert(
      table,
      data,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtils.database();
    return db.query(table);
  }
}
