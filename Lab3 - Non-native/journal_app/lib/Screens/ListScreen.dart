import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/Screens/AddStoryScreen.dart';
import 'package:journal_app/Screens/UpdateStoryScreen.dart';
import '../Story.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final List<Story> stories = Story.init();

  Story? getStoryById(int id) {
    for (Story s in stories) {
      if (s.id == id) return s;
    }
  }

  void update(Story newStory){
    for(int i = 0; i < stories.length; i++){
      if(stories[i].id == newStory.id) {
        stories[i] = newStory;
      }
    }
  }

  void removeFromList(int id) {
    stories.removeWhere((element) => element.id == id);
  }

  _showDialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("CupertinoAlertDialog"),
              content: const Text("Are you sure you want to delete this item?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Yes"),
                  onPressed: () {
                    setState(() {
                      removeFromList(id);
                      Navigator.of(context).pop();
                    });
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("No"),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFFFFECB3),
      ),
      body: Center(
        child: Container(
            color: Colors.orange.shade300,
            child: ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return templateStory(stories[index]);
                })),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Story story = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStoryScreen()));
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added!"),
              ));
              stories.add(story);
            });
          },
          backgroundColor: Colors.black45,
          child: const Icon(Icons.add)),
    );
  }

  Widget templateStory(story) {
    return Card(
        elevation: 0,
        // margin: EdgeInsets.zero,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Container(
            color: Colors.orange.shade300,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0XFFFFECB3),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      "${story.title}    ${DateFormat('yyyy-MM-dd').format(story.date)}     ${story.emotion}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: IconButton(
                          onPressed: () => {_showDialog(context, story.id)},
                          icon: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                          onPressed: ()  async {
                            Story story2 = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UpdateStoryScreen(story: story!)));
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Updated!"),
                              ));
                              update(story2);
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.pen,
                            size: 25,
                          )),
                    )
                  ])
                ],
              ),
            )));
  }
}
