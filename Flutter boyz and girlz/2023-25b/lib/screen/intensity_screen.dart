import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/local_database_repository.dart';

class IntensityScreenWidget extends StatefulWidget {
  const IntensityScreenWidget({Key? key}) : super(key: key);

  @override
  State<IntensityScreenWidget> createState() => _IntensityScreenWidgetState();
}

class _IntensityScreenWidgetState extends State<IntensityScreenWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<LocalDatabaseRepository>(context);
    return Scaffold(
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
                                  ]),
                                  trailing: SizedBox(
                                    width: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: IconButton(
                                                onPressed: () => {
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //       builder:
                                                      //           (context) =>
                                                      //               UpdateScreen(
                                                      //                 activity:
                                                      //                     storage
                                                      //                         .easiestActivities[index],
                                                      //               )),
                                                      // )
                                                    },
                                                icon: const Icon(Icons.edit))),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        })),
              ],
            );
          }
        },
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Intensity Section"),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Main"),
              )
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.pop(context);
            }
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
