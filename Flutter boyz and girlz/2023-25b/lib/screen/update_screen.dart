import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/entity.dart';
import '../model/local_database_repository.dart';

class UpdateScreen extends StatefulWidget {
  final Entity activity;
  const UpdateScreen({Key? key, required this.activity}) : super(key: key);
  @override
  State<UpdateScreen> createState() =>
      // ignore: no_logic_in_create_state
      UpdateScreenState(activity);
}

class UpdateScreenState extends State<UpdateScreen> {
  late Entity activity;
  String intensity = "";
  final _formKey = GlobalKey<FormState>();

  UpdateScreenState(this.activity) {
    //intensity = activity.intensity;
  }

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
                      //initialValue: activity.intensity,
                      decoration: const InputDecoration(
                        hintText: "easy/medium/hard",
                        labelText: "Intensity",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The activity must have a name!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          intensity = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextButton(
                      onPressed: () {
                        storage.updateActivity(intensity, activity.id);
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
