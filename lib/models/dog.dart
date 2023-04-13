class Dog {
  final String? id;
  final String name;
  final String description;
  final String photo;

  const Dog({this.id, this.name = '', this.description = '', this.photo = ''});

  Dog copyWith({String? name, String? description, String? photo}) {
    return Dog(
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
    );
  }
}
