import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/entity.dart';
import '../model/local_database_repository.dart';
import '../websocket.dart';
import 'add_screen.dart';
import 'intensity_screen.dart';
import 'update_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  MainScreenState();
  late Future<List<Entity>> activitiesByCategory;
  late String currentlySelectedCategory = "";

  showAlertDialog(BuildContext context, int index,
      LocalDatabaseRepository storage, Entity entityToBeDeleted) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        setState(() {
          storage.deleteActivity(entityToBeDeleted.id);
        });
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Delete activity"),
      content: const Text("Are you sure you want to delete this entity?"),
      actions: [okButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForNotification(BuildContext context, Entity recipe) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Notification"),
      actions: [okButton],
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Id: " + recipe.id.toString()),
        SizedBox(
          height: 10.0,
        ),
        Text("Name: " + recipe.name),
        SizedBox(
          height: 10.0,
        ),
        Text("Description: " + recipe.description),
        SizedBox(
          height: 10.0,
        ),
        Text("Date: " + recipe.ingredients),
        SizedBox(
          height: 10.0,
        ),
        Text("Time: " + recipe.instructions),
        SizedBox(
          height: 10.0,
        ),
        Text("Category: " + recipe.category),
        SizedBox(
          height: 10.0,
        ),
        Text("intensity: " + recipe.difficulty),
        SizedBox(
          height: 10.0,
        ),
      ]),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<LocalDatabaseRepository>(context);
    if (!WebSocketInterface.isListened) {
      WebSocketInterface.listen().listen((event) {
        WebSocketInterface.isListened = true;
        setState(() {
          Entity recipe = Entity.fromJson(json.decode(event));
          print("Notification");
          showAlertDialogForNotification(context, recipe);
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
      ),
      body: FutureBuilder(
        future: storage.futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                PopupMenuButton(
                    // add icon, by default "3 dot" icon
                    // icon: Icon(Icons.book)
                    itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Intensity"),
                    )
                  ];
                }, onSelected: (value) {
                  if (storage.connected.value) {
                    if (value == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IntensityScreenWidget();
                      }));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You are offline!')),
                    );
                  }
                }),
                const SizedBox(height: 10),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: storage.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = storage.categories[index];
                          return InkWell(
                              child: Card(
                                  color: Colors.white70,
                                  child: ListTile(
                                    title: Column(children: [
                                      Text(storage.categories[index])
                                    ]),
                                    onTap: () {
                                      print("should change");
                                      currentlySelectedCategory = item;
                                      storage.getRecipesByCategory(item);
                                    },
                                  )));
                        })),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: storage.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: Colors.white70,
                              child: ListTile(
                                title: Column(children: [
                                  Text(storage.recipes[index].name),
                                  Text(storage.recipes[index].description),
                                  Text(storage.recipes[index].category),
                                  Text(storage.recipes[index].ingredients
                                      .toString()),
                                  Text(storage.recipes[index].instructions
                                      .toString()),
                                  Text(storage.recipes[index].difficulty
                                      .toString()),
                                ]),
                                trailing: SizedBox(
                                  width: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: IconButton(
                                              onPressed: () {
                                                showAlertDialog(
                                                    context,
                                                    index,
                                                    storage,
                                                    storage.recipes[index]);
                                              },
                                              icon: const Icon(Icons.delete)))
                                    ],
                                  ),
                                ),
                              ));
                        }))
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          )
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
