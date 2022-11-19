import 'dart:ffi';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:journal_app/Repo/DatabaseConnection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Story.dart';

class DatabaseRepo {
  static const _dbName = "stories.db";
  static const _dbVersion = 1;
  static const _table = "story";

  //singleton pattern
  DatabaseRepo._();

  static final DatabaseRepo dbInstance = DatabaseRepo._();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_table
        (_id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        emotion TEXT NOT NULL,
        motivationalMessage TEXT NOT NULL,
        text TEXT NOT NULL)''');
  }

  Future<List<Story>> getStories() async {
    Database db = await dbInstance.database;

    var stories = await db.query(_table);

    List<Story> storyList = stories.isNotEmpty
      ? stories.map((s) => Story.fromMap(s)).toList()
        : [];

    return storyList;
  }

  Future<int> add(Story story) async {
    Database db = await dbInstance.database;

    return await db.insert(_table, story.toMap());
  }

  Future<int> removeFromList(int id) async {
    Database db = await dbInstance.database;
    return await db.delete(_table, where: '_id = ?', whereArgs: [id]);
  }

  Future<int> update(Story story) async {
    Database db = await dbInstance.database;
    return await db.update(_table, story.toMap(), where: '_id = ?', whereArgs: [story.id]);
  }

// static late Database _database;
//
//
// //we get the database reference everytime we need it
// Future<Database> get database async {
//   if (_database != null) return _database;
//   _database = await _initDB();
//   await addInitData();
//   return _database;
// }
//
// //open the db an create it if it doesn't exist
// _initDB() async {
//   Directory documentsDirectory = await getApplicationDocumentsDirectory();
//   final path = join(documentsDirectory.path, _dbName);
//
//   return await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
// }
//
// _onCreatingDatabase(Database database, int version) async {
//   await database.execute(
//       "CREATE TABLE $table"
//           "(_id INTEGER PRIMARY KEY AUTOINCREMENT,"
//           "title TEXT NOT NULL, "
//           "date TEXT NOT NULL,"
//           "emotion TEXT NOT NULL, "
//           "motivationalMessage TEXT NOT NULL, "
//           "text TEXT NOT NULL)"
//   );
// }
//
// Future<List<Story>> getStories() async {
//   Database db = await dbInstance.database;
//   var rows = await db.query(table);
//   var list = <Story>[];
//
//   for(var row in rows){
//     list.add(Story(id: row["_id"], title: row["title"], text: row["text"], date: row["date"], emotion: row["emotion"], motivationalMessage: row["motivationalMessage"]));
//   }
//
//   return await Future.value(list);
// }
//
//
// Future<int> add(Story story) async {
//   final db = await dbInstance.database;
//
//   final id = await db.insert(table, story.toJson());
//
//   return id;
// }
//
// // Future<Story> readNote(int id) async {
// //   final db = await dbInstance.database;
// //
// //   final maps = await db.query(
// //     "story",
// //     columns:
// //   )
// // }
//
//
// Future close() async {
//   final db = await dbInstance.database;
//   db.close();
// }
//
// Future<String> addInitData() async {
//   List<Story> stories = [
//     Story(title: "Lolaaaaaaaaaaaaaaaaaaaa", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 03))), emotion: "Happy",
//         motivationalMessage: "Some review..."),
//     Story(title: "Lola2", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 04))), emotion: "Sad",
//         motivationalMessage: "Some review..."),
//     Story(title: "Lola3", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 05))), emotion: "Angry",
//         motivationalMessage: "Some review..."),
//     Story(title: "Lola4", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 06))),
//         emotion: "Anxious", motivationalMessage: "Some review..."),
//     Story(title: "Lola5", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 07))),
//         emotion: "Neutral", motivationalMessage: "Some review..."),
//     Story(title: "Lola6", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 08))),
//         emotion: "Ambitious", motivationalMessage: "Some review..."),
//     Story(title: "Lola7", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 09))),
//         emotion: "Nervous", motivationalMessage: "Some review...")
//   ];
//
//   for(var story in stories ) {
//     await add(story);
//   }
//
//   return "ok";
// }

}
