import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'entity.dart';

class LocalDatabaseRepository extends ChangeNotifier {
  List<Entity> items = [];
  late Future<List<String>> futureCategories;
  List<String> categories = [];
  List<Entity> recipes = [];
  List<Entity> easiest = [];
  late Future<List<Entity>> futureEasiest = getEasiest();
  late Future<List<Entity>> futureRecipes;
  static final String urlServer = "http://127.0.0.1:2325";
  ValueNotifier<bool> connected = ValueNotifier(false);
  static final ValueNotifier<bool> notifier = ValueNotifier(false);
  static final log = Logger('ActivityService');

  LocalDatabaseRepository() {
    futureCategories = getCategories();
    notifyListeners();
  }

  Future<List<String>> getCategories() async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("Using existent categories offline");
      return categories;
    }
    var url = Uri.parse(urlServer + "/categories");
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)
          .map<String>((t) => t.toString())
          .toList() as List<String>;
    } else {}
    log.info("GET " + urlServer + "/categories");
    categories.forEach((element) {
      print(element);
    });
    print("RETURNED ALL THE CATEGORIES!!");
    return categories;
  }

  Future<List<Entity>> getEasiest() async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("Using existent categories offline");
      return easiest;
    }
    var url = Uri.parse(urlServer + "/easiest");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      easiest = jsonDecode(response.body)
          .map<Entity>((t) => Entity.fromJson(t))
          .toList() as List<Entity>;
    } else {}
    log.info("GET " + urlServer + "/easiest");

    easiest.sort((a, b) {
      int dateComparison = compareDifficulty(a.difficulty, b.difficulty);
      if (dateComparison == 0) {
        return a.category.compareTo(b.category);
      }
      return dateComparison;
    });

    notifyListeners();
    return easiest;
  }

  int compareDifficulty(String difficulty1, String difficulty2) {
    if (difficulty1 == difficulty2) {
      return 0;
    }
    if (difficulty1 == "hard") {
      return -1;
    }
    if (difficulty2 == "hard") {
      return 1;
    }
    if (difficulty1 == "medium") {
      return -1;
    }
    if (difficulty2 == "medium") {
      return 1;
    }
    if (difficulty1 == "easy") {
      return -1;
    }
    if (difficulty2 == "easy") {
      return 1;
    }
    return -1;
  }

  Future<List<Entity>> getRecipesByCategory(String category) async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("Using existent categories offline");
      return recipes;
    }
    var url = Uri.parse(urlServer + "/recipes/" + category);
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      recipes = jsonDecode(response.body)
          .map<Entity>((t) => Entity.fromJson(t))
          .toList() as List<Entity>;
    } else {}
    log.info("GET " + urlServer + "/recipes/" + category);
    notifyListeners();
    return recipes;
  }

  Future<void> addActivity(EntityDTO item) async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("You cannot add! You are offline.");
      throw SocketException("Lost internet connection. You are now offline.");
    }

    var url = Uri.parse(urlServer + "/recipe");
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(item.toMap()));
    if (response.statusCode != 200) {
      throw FormatException("Invalid Activity!");
    }
    log.info("POST " + urlServer + "/recipe");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<void> deleteActivity(int id) async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("You cannot add! You are offline.");
      throw SocketException("Lost internet connection. You are now offline.");
    }

    var url = Uri.parse(urlServer + "/recipe/" + id.toString());
    var response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw FormatException("Invalid Activity!");
    }
    log.info("DELETE " + urlServer + "/recipe/" + id.toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<void> updateActivity(String intensity, int id) async {
    await checkConnectivity();
    if (!connected.value) {
      log.info("You cannot update! You are offline.");
      throw SocketException("Lost internet connection. You are now offline.");
    }
    var url = Uri.parse(urlServer + "/intensity");
    Map<String, dynamic> data = Map();
    data["id"] = id;
    data["intensity"] = intensity;

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data));
    log.info("POST " + urlServer + "/intensity");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<bool> checkConnectivity() async {
    var oldConnected = connected.value;
    try {
      var url = Uri.parse(urlServer + "/categories");
      final response = await http.get(url);
      if (response.statusCode != 200) {
        connected.value = false;
      } else {
        connected.value = true;
      }
    } on SocketException catch (e) {
      if (oldConnected) {
        connected.value = false;
      }
    }
    log.info("connected: " + connected.value.toString());
    return connected.value;
  }

  Future<void> add(EntityDTO entity) async {
    var insertedEntity = await DatabaseHelper.instance.add(entity);

    print(insertedEntity);

    items.add(insertedEntity!);
    notifyListeners();
  }

  Entity findById(int id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> update(Entity activity) async {
    var updatedActivity = null;
    await DatabaseHelper.instance
        .update(activity)
        .then((value) => updatedActivity = value);

    int index = items.indexWhere((element) => element.id == activity.id);
    items[index] = updatedActivity!;
    notifyListeners();
  }

  void delete(int activity_id) {
    items.removeWhere((element) => element.id == activity_id);
    notifyListeners();
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const tableName = 'mobile_app1';

  static Database? _database;
  Future<Database?> get database async => _database ??= await _initDatabase();

  void logErrorToFile(String error) async {
    final file = File('error_log.txt');
    await file.writeAsString(error);
  }

  Future<Database?> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // await deleteDatabase(documentsDirectory.path);
    try {
      String path = join(documentsDirectory.path, 'mobile_app1.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      logErrorToFile(e.toString());
    }
    return null;
  }

  Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE mobile_app1(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(30)
      )''');
    } catch (e) {
      logErrorToFile(e.toString());
    }
  }

  Future<List<Entity>> getAll() async {
    Database? db = await instance.database;
    var entities = await db!.query(tableName);

    List<Entity> entityList = [];
    try {
      for (int i = 0; i < entities.length; i++) {
        entityList.add(Entity.fromJson(entities[i]));
      }
    } catch (e) {
      logErrorToFile(e.toString());
    }
    return entityList;
  }

  Future<Entity?> getById(int id) async {
    Database? db = await instance.database;

    var possibleEntities =
        await db?.query(tableName, where: 'id = ?', whereArgs: [id]);

    Entity? foundEntity = null;
    try {
      for (int i = 0; i < possibleEntities!.length; i++) {
        foundEntity = Entity.fromJson(possibleEntities[i]);
        break;
      }
    } catch (e) {
      logErrorToFile(e.toString());
    }
    return foundEntity;
  }

  Future<Entity?> add(EntityDTO entity) async {
    print("???");
    print(entity.name);
    Database? db = await instance.database;
    int? id = await db?.insert(tableName, entity.toMap());
    if (id != null) {
      Entity? insertedActivity = await getById(id!);
      return insertedActivity!;
    }
    print(entity.name);
    return null;
  }

  Future<Entity?> update(Entity entity) async {
    Database? db = await instance.database;
    db?.update(tableName, entity.toMap(),
        where: 'id = ?', whereArgs: [entity.id]);

    try {
      Entity? updatedActivities = await getById(entity.id);
      return updatedActivities!;
    } catch (e) {
      logErrorToFile(e.toString());
    }
    return null;
  }

  Future remove(int id) async {
    Database? db = await instance.database;
    try {
      await db?.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      logErrorToFile(e.toString());
    }
  }
}
