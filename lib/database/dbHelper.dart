import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper helper = DbHelper._();

  Database? _database;
  final databaseName = 'contact.db';
  final tableName = 'contact';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
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
          phone INTEGER NOT NULL,
          email TEXT NOT NULL,
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<bool> contactFire(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> addContactToDatabase(
      int id, String name, int phone , String email) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName(
    id, name, phone, email,
    ) VALUES (?, ?, ?, ?)
    ''';
    List args = [id, name, phone, email];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllContact() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> searchContact(String name) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE name LIKE '%$name%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateContact(int id, String name, int phone, String email) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET name = ?, phone = ?, email = ?, WHERE id = ?
    ''';
    List args = [name,phone,email, id];
    return await db.rawUpdate(sql, args);
  }
  Future<int> deleteContact(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}