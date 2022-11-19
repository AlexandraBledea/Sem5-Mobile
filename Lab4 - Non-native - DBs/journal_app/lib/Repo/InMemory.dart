import '../Story.dart';

class InMemory {

  List<Story> stories = Story.init();

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

  void add(Story s){
    stories.add(s);
  }

  void removeFromList(int id) {
    stories.removeWhere((element) => element.id == id);
  }

}