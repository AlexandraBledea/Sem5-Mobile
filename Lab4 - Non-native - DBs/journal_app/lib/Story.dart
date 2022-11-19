import 'package:intl/intl.dart';

class Story {
  static int currentId = 0;
  int? id;
  String title;
  String emotion;
  String motivationalMessage;
  DateTime date;
  String text;

  Story({this.id, required this.title, required this.text, required this.date, required this.emotion, required this.motivationalMessage});

  // Map<String, Object?> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "date": date.toIso8601String(),
  //   "emotion": emotion,
  //   "motivationalMessage": motivationalMessage,
  //   "text": text
  // };

  factory Story.fromMap(Map<String, dynamic> json) => Story(
    id: json['_id'],
    title: json['title'],
    date: DateTime.parse(json['date']),
    emotion: json['emotion'],
    motivationalMessage: json['motivationalMessage'],
    text: json['text']
  );

  Map<String, dynamic> toMap(){
    return {
      '_id': id,
      'title': title,
      'date': date.toIso8601String(),
      'emotion': emotion,
      'motivationalMessage': motivationalMessage,
      'text': text
    };
  }

  static List<Story> init() {

    List<Story> stories = [
      Story(title: "Lolaaaaaaaaaaaaaaaaaaaa", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 03))), emotion: "Happy",
          motivationalMessage: "Some review..."),
      Story(title: "Lola2", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 04))), emotion: "Sad",
          motivationalMessage: "Some review..."),
      Story(title: "Lola3", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 05))), emotion: "Angry",
          motivationalMessage: "Some review..."),
      Story(title: "Lola4", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 06))),
          emotion: "Anxious", motivationalMessage: "Some review..."),
      Story(title: "Lola5", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 07))),
          emotion: "Neutral", motivationalMessage: "Some review..."),
      Story(title: "Lola6", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 08))),
          emotion: "Ambitious", motivationalMessage: "Some review..."),
      Story(title: "Lola7", text: "aaaaa", date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 09))),
          emotion: "Nervous", motivationalMessage: "Some review...")
    ];

    return stories;
  }
}
