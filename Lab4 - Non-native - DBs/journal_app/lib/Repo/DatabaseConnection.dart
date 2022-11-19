import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseConnection {

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_stories');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
      "CREATE TABLE story"
          "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT NOT NULL, "
          "date TEXT NOT NULL,"
          "emotion TEXT NOT NULL, "
          "motivationalMessage TEXT NOT NULL, "
          "text TEXT NOT NULL)"
    );
  }

}