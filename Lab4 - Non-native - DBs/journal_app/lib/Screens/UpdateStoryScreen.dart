import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import '../Story.dart';

class UpdateStoryScreen extends StatefulWidget {

  const UpdateStoryScreen({super.key,
    required this.story});

  final Story story;

  @override
  State<StatefulWidget> createState() => UpdateStoryScreenState();
}

class UpdateStoryScreenState extends State<UpdateStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }

    return true;
  }


  @override
  Widget build(BuildContext context) {

    String titleValue = widget.story.title;
    String emotionValue = widget.story.emotion;
    String messageValue = widget.story.motivationalMessage;
    String dateValue = DateFormat("yyyy-MM-dd").format(widget.story.date);
    String textValue = widget.story.text;


    return Scaffold(
        backgroundColor: Colors.orange.shade300,
        body: Container(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: const Text('Update note',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SomeFam')),
                      ),
                      const Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: Text("Date",
                      style: TextStyle(
                        fontFamily: "SomeFam",
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                        child: SizedBox(
                          width: 140,
                          child: TextFormField(
                            initialValue: DateFormat("yyyy-MM-dd").format(widget.story.date),
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                log('UpdateScreen - Date error: Please add some text');
                                return "Please add some text";
                              } else if(!isValidDate(value)){
                                log('UpdateScreen - Date error: Use format: yyyy-MM-dd');
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
                  const Text("Title",
                  style: TextStyle(
                    fontFamily: "SomeFam",
                    fontWeight: FontWeight.bold,
                    fontSize: 21
                  ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        initialValue: widget.story.title,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('UpdateScreen - Title error: Please add some text');
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
                  const Text("Emotion",
                    style: TextStyle(
                        fontFamily: "SomeFam",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        initialValue: widget.story.emotion,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('UpdateScreen - Emotion error: Please add some text');
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
                  const Text("Motivational message",
                    style: TextStyle(
                        fontFamily: "SomeFam",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        initialValue: widget.story.motivationalMessage,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            log('UpdateScreen - Motivational message error: Please add some text');
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
                  const Text("Text",
                    style: TextStyle(
                        fontFamily: "SomeFam",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 370,
                        height: 300,
                        child: TextFormField(
                          initialValue: widget.story.text,
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              log('UpdateScreen - Text error: Please add some text');
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
                                    Navigator.pop(context,Story(id: widget.story.id, title: titleValue, text: textValue, date: DateTime.parse(dateValue), emotion: emotionValue, motivationalMessage: messageValue))
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
