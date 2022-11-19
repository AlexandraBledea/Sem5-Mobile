import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/Repo/DatabaseRepo.dart';
import 'package:journal_app/Repo/InMemory.dart';
import 'package:journal_app/Screens/AddStoryScreen.dart';
import 'package:journal_app/Screens/UpdateStoryScreen.dart';
import '../Story.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {

  DatabaseRepo databaseRepo = DatabaseRepo.dbInstance;

  late List<Story> stories;

  void getStoriesFromFuture() async {
    stories = await databaseRepo.getStories();
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
                  onPressed: () async{
                    await databaseRepo.removeFromList(id);
                    setState(() {
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
    getStoriesFromFuture();
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
            child: _buildListOfStories()),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Story story = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddStoryScreen()));
                await databaseRepo.add(story);
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added!"),
              ));
            });
          },
          backgroundColor: Colors.black45,
          child: const Icon(Icons.add)),
    );
  }


  //the future builder waits for the result to be completed and only
  //then it calls the build
  //if it's not ready it returns an empty container
  Widget _buildListOfStories(){
    return FutureBuilder(
        builder: (context, story) {
          if(story.connectionState == ConnectionState.none && story.connectionState == null){
            return Container();
        } else if(!story.hasData){
            return Container();
          }
        return ListView.builder( itemCount: story.data!.length,
            itemBuilder: (context, index) {
            return templateStory(story.data![index]);
       }
       );
    },
    future: databaseRepo.getStories(),
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
                          onPressed: () => { _showDialog(context, story.id)},
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
                            await databaseRepo.update(story2);
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Updated!"),
                              ));
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
