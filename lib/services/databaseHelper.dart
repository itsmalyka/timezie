import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezie/models/noteModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
    path,
    version: 1,
    onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, startTime TEXT, endTime TEXT, status TEXT, completionPercentage DOUBLE, category TEXT)',
    );
  }

  Future<int> insert(notemodel note) async {
    Database db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<notemodel>> getNotes() async {
    Database db = await database;
    var res = await db.query('notes');
    List<notemodel> list = res.isNotEmpty ? res.map((c) => notemodel.fromMap(c)).toList() : [];
    return list;
  }
  Future<int> update(notemodel note) async {
    Database db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}



