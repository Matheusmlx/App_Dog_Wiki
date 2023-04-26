import 'package:flutter/cupertino.dart';

class Dog {
  final String? id;
  final String name;
  final String description;
  final String photo;
  final List<IconData?> caracteristicas;

  const Dog(
      {this.id,
      this.name = '',
      this.description = '',
      this.photo = '',
      this.caracteristicas = const [],
      });

  Dog copyWith(
      {String? name,
      String? description,
      String? photo,
      List<IconData?>? caracteristicas}) {
        print("Copywith ${caracteristicas}");
    return Dog(
        name: name ?? this.name,
        description: description ?? this.description,
        caracteristicas: caracteristicas ?? this.caracteristicas,
        photo: photo ?? this.photo);
  }
}
