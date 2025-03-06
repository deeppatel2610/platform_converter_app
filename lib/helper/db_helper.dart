import 'package:path/path.dart';
import 'package:platform_converter_app/model/content_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  Database? _database;
  String dbName = "content";
  String dbUser = "user";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myDb.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $dbName(id INTEGER PRIMARY KEY, name TEXT, number INTEGER, bio TEXT, email TEXT)',
        );

        await db.execute(
          'CREATE TABLE $dbUser(id INTEGER PRIMARY KEY, name TEXT, number INTEGER, bio TEXT, email TEXT)',
        );
      },
    );
  }

  Future<void> insertData({
    required String name,
    required int number,
    required String bio,
    required String email,
    required String tebName,
  }) async {
    Database? db = await database;
    String sql =
        'INSERT INTO $tebName(name, number, bio, email) VALUES(?, ?, ?, ?)';
    List r = [name, number, bio, email];
    await db!.rawInsert(sql, r);
  }

  Future<void> update({
    required ContentModel model,
    required String tebName,
  }) async {
    Database? db = await database;
    await db!.update(
      tebName,
      ContentModel.toMap(model),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  Future<List<Map<String, Object?>>> readDate({required String tebName}) async {
    Database? db = await database;
    return await db!.query(tebName);
  }

  Future<void> delete({required int id}) async {
    Database? db = await database;
    await db!.delete(dbName, where: "id = ?", whereArgs: [id]);
  }
}
