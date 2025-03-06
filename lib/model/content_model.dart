class ContentModel {
  int? id, number;
  String? name, email, bio;

  ContentModel({
    this.id,
    required this.number,
    required this.name,
    required this.email,
    required this.bio,
  });

  factory ContentModel.fromMap(Map m1) => ContentModel(
    id: m1['id'],
    number: m1['number'],
    name: m1['name'],
    email: m1['email'],
    bio: m1['bio'],
  );

  static Map<String, Object?> toMap(ContentModel model) {
    return {
      'id': model.id,
      'name': model.name,
      'number': model.number,
      'email': model.email,
      'bio': model.bio,
    };
  }
}
