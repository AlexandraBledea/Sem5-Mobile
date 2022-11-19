import 'package:intl/intl.dart';

class Story {
  static int currentId = 0;
  late int id;
  String title;
  String emotion;
  String motivationalMessage;
  DateTime date;
  String text;

  Story(this.title, this.text, this.date, this.emotion, this.motivationalMessage) {
    id = currentId++;
  }

  Story.fromStory(this.id, this.title, this.text, this.date, this.emotion, this.motivationalMessage);

  static List<Story> init() {

    List<Story> stories = [
      Story("Lolaaaaaaaaaaaaaaaaaaaa", "aaaaa",     DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 03))), "Happy",
          "Some review..."),
      Story("Lola2", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 04))), "Sad",
          "Some review..."),
      Story("Lola3", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 05))), "Angry",
          "Some review..."),
      Story("Lola4", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 06))),
          "Anxious", "Some review..."),
      Story("Lola5", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 07))),
          "Neutral", "Some review..."),
      Story("Lola6", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 08))),
          "Ambitious", "Some review..."),
      Story("Lola7", "aaaaa", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(1999, 04, 09))),
          "Nervous", "Some review...")
    ];

    return stories;
  }
}
