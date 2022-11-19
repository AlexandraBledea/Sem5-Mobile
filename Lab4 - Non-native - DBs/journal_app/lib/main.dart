import 'package:flutter/material.dart';
import 'package:journal_app/Repo/InMemory.dart';
import 'package:journal_app/Screens/AddStoryScreen.dart';

import 'Screens/ListScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
      home: MyMainScreen()
  )
  );
}

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyMainScreenState();
}

class MyMainScreenState extends State<MyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade300,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(60, 100, 20, 0),
            child: Image(
              image: AssetImage("assets/logo.png"),
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListScreen()))
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade200
                  ),
                  child: const Text(
                    "Enter your world!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SomeFam'
                    )),
                )
          )
        ],
      ),
    );
  }
}