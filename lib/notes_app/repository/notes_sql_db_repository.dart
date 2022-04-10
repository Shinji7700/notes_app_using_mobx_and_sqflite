import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notes_model.dart';

class NotesSqlDbRepository {
  ///Here we create a instance so that we can access the database from this class
  static final NotesSqlDbRepository instance = NotesSqlDbRepository._init();

  ///Here we get the database from sqflite package
  static Database? _database;

  ///Here we initialize the private constructor created for this class
  NotesSqlDbRepository._init();

  ///Here we check if the database is null if null then initialize database else get
  ///the databse that is already created
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb('notesSql.db');
    return _database!;
  }

  ///Here we initialise db by opening it and storing it in our device using sqflite package
  ///path or we can get the documents folder path by using path_provider package
  ///and then we open db by adding path,version no and once the db is open then we created db
  Future<Database> _initDb(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  ///Here we create db by using sql cmd for create table with columns and its type
  Future _createDb(Database db, int version) async {
    await db.execute('''
CREATE TABLE $sqlTableName (
  ${SqlTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${SqlTableFields.title} TEXT NOT NULL,
  ${SqlTableFields.description} TEXT NOT NULL,
  ${SqlTableFields.createdAt} TEXT NOT NULL
)
 ''');
  }

  ///Here we add the notes into db by calling the global instance created and then insert the data
  ///by giving its table name and then the values in JSON format
  Future<NotesModel> createNotes(NotesModel notesModel) async {
    final db = await instance.database;
    final id = await db.insert(sqlTableName, notesModel.toJson());

    return notesModel.copyWith(id: id);
  }

  ///Here we read the specific note from db based on its id
  Future<NotesModel> readNotes(int id) async {
    final db = await instance.database;
    final mapData = await db.query(sqlTableName,
        columns: SqlTableFields.values,
        where: '${SqlTableFields.id} = ?',
        whereArgs: [id]);

    if (mapData.isNotEmpty) {
      return NotesModel.fromJson(mapData.first);
    } else {
      throw Exception("Data not found. Please check the db");
    }
  }

  ///Here we read the entire db table
  Future<List<NotesModel>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query(sqlTableName,
        orderBy: "${SqlTableFields.createdAt} ASC");
    return result.map((json) => NotesModel.fromJson(json)).toList();
  }

  ///Here we update the specific note
  Future<int> updateNotes(NotesModel notesModel) async {
    final db = await instance.database;

    return db.update(sqlTableName, notesModel.toJson(),
        where: '${SqlTableFields.id} = ?', whereArgs: [notesModel.id]);
  }

  ///Here we delete the specific note
  Future<int> deleteNotes(int id) async {
    final db = await instance.database;

    return db.delete(sqlTableName,
        where: '${SqlTableFields.id} = ?', whereArgs: [id]);
  }

  ///Here we close db when not needed
  Future closeDb() async {
    final db = await instance.database;
    db.close();
  }
}
