import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';


import '../Story.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddStoryScreenState();
}

class AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }

    return true;
  }

  String titleValue = "";
  String emotionValue = "";
  String messageValue = "";
  String dateValue = "";
  String textValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade300,
        body: Container(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: const Text('Create note',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SomeFam')),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(83, 27, 0, 0),
                        child: SizedBox(
                          width: 140,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                log('AddScreen - Date error: Please add some text');
                                return "Please add some text";
                              } else if(!isValidDate(value)){
                                log('AddScreen - Date error: Use format: yyyy-MM-dd');
                                  return "Use format: yyyy-MM-dd";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (value) => dateValue = value,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color(0XFFFFECB3),
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SomeFam'),
                              hintText: 'Date...',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('AddScreen - Title error: Please add some text');
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => titleValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFFFECB3),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam'),
                          hintText: 'Title...',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('AddScreen - Emotion error: Please add some text');
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => emotionValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFFFECB3),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam'),
                          hintText: 'Emotion...',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('AddScreen - Motivational message error: Please add some text');
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => messageValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFFFECB3),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SomeFam'),
                          hintText: 'Motivational message...',
                        ),
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 370,
                        height: 390,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              log('AddScreen - Text error: Please add some text');
                              return "Please fill up all the fields!";
                            }
                            else {
                              return null;
                            }
                          },
                          onChanged: (value) => textValue = value,
                          maxLines: 400,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color(0XFFFFECB3),
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SomeFam'),
                            hintText: 'Text...',
                          ),
                        ),
                      ),
                  ),
                  Row(children: <Widget>[
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                          child: SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () =>
                                {
                                  if(_formKey.currentState!.validate()){
                                    Navigator.pop(context,Story(title: titleValue, text: textValue, date: DateTime.parse(dateValue), emotion: emotionValue, motivationalMessage: messageValue))
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFFFECB3)),
                                child: const Text("Save",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SomeFam')),
                              )),
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                          child: SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => {Navigator.pop(context)},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFFFECB3)),
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SomeFam')),
                              )),
                        ))
                  ])
                ])))));
  }
}
