import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/entity.dart';
import '../model/local_database_repository.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);
  @override
  State<CreateScreen> createState() => CreateScreenState();
}

class CreateScreenState extends State<CreateScreen> {
  String name = "";
  String description = "";
  String category = "";
  String ingredients = "";
  String difficulty = "";
  String instructions = "";
  final _formKey = GlobalKey<FormState>();

  CreateScreenState();

  showAlertWhenInvalidValue(BuildContext context, String alertText) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        setState(() {});
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Incorrect value"),
      content: Text(alertText),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertWhenActivityNotAdded(
      BuildContext context, String alertTitle, String alertText) {
    Widget okButton = ElevatedButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertText),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertWhenActivityAdded(
      BuildContext context, String alertTitle, String alertText) {
    Widget okButton = ElevatedButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        //Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertText),
      actions: [okButton],
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
    return Material(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        key: _formKey,
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Description",
                        labelText: "Description",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a description!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Category",
                        labelText: "Category",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          category = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Instructions",
                        labelText: "Instructions",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          instructions = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Ingredients",
                        labelText: "Ingredients",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          ingredients = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Difficulty",
                        labelText: "Difficulty",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          difficulty = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextButton(
                      onPressed: () {
                        storage.addActivity(EntityDTO(
                            name: name,
                            category: category,
                            difficulty: difficulty,
                            ingredients: ingredients,
                            instructions: instructions,
                            description: description));
                        Navigator.of(context).pop();
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
