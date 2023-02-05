class Entity {
  int id; // = const Uuid().v4();
  String name;
  String description;
  String ingredients;
  String instructions;
  String category;
  String difficulty;

  Entity(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.ingredients,
      required this.instructions,
      required this.difficulty});

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        id: json['id'],
        name: json['name'],
        description: json["description"],
        category: json["category"],
        difficulty: json["difficulty"],
        instructions: json["instructions"],
        ingredients: json["ingredients"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'instructions': instructions,
      'ingredients': ingredients,
      'difficulty': difficulty
    };
  }
}

class EntityDTO {
  String name;
  String description;
  String ingredients;
  String instructions;
  String category;
  String difficulty;

  EntityDTO(
      {required this.name,
      required this.description,
      required this.category,
      required this.ingredients,
      required this.instructions,
      required this.difficulty});

  factory EntityDTO.fromJson(Map<String, dynamic> json) {
    return EntityDTO(
        name: json['name'],
        description: json["description"],
        category: json["category"],
        difficulty: json["difficulty"],
        instructions: json["instructions"],
        ingredients: json["ingredients"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'instructions': instructions,
      'ingredients': ingredients,
      'difficulty': difficulty
    };
  }
}
