import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper helper = DbHelper._();

  Database? _database;
  String databaseName = 'attendance.db';
  String tableName = 'attendance';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    {
      final path = await getDatabasesPath();
      final dbPath = join(path, databaseName);
      return await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          String sql = '''
        CREATE TABLE $tableName (
          id INTEGER NOT NULL,
          name TEXT NOT NULL,
          room TEXT NOT NULL,
          date TEXT NOT NULL,
          status TEXT NOT NULL
        )
        ''';
          db.execute(sql);
        },
      );
    }
  }

  Future<bool> DataExist(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> insertData(
      {required int id,
      required String name,
      required String room,
      required String date,
      required String status}) async {
    final db = await database;
    String sql = '''
     INSERT INTO $tableName(
    id, name, room, date, status
    ) VALUES (?, ?, ?, ?, ?)
    ''';
    List args = [id, name, room, date, status];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllData() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getSearchByName(String name) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE name LIKE '%$name%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateData(
      int id, String name, String room, String date, String status) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET name = ?, room = ?,date = ? , status = ? WHERE id = ?
    ''';
    List args = [name, room, date, status, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    String sql = '''
  DELETE FROM $tableName WHERE id = ?
  ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}
