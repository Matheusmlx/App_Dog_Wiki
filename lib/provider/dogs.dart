import 'package:dog_wiki/data/dummy_dogs.dart';
import 'package:dog_wiki/models/dog.dart';
import 'package:flutter/material.dart';

class Dogs with ChangeNotifier {
  final Map<String, Dog> _items = {...DUMMY_DOGS};

  get all {
    return [..._items.values];
  }

  int get size {
    return _items.length;
  }

  Dog byIndex(int i) {
    return _items.values.elementAt(i);
  }

  put(Dog? dog) {
    if (dog == null) {
      return;
    }
    if (dog.id != null && dog.id!.isNotEmpty && _items.containsKey(dog.id)) {
      _items.update(dog.id!, (_) => dog);
    } else {
      final id = (_items.length).toString();
      _items.putIfAbsent(
          id,
          () => Dog(
              id: id,
              name: dog.name,
              description: dog.description,
              photo: dog.photo,
              caracteristicas: dog.caracteristicas));
    }

    notifyListeners();
  }

  deleteDog(String idDog) async {
    Dog findDog = _items.values.firstWhere((element) => element.id == idDog);

    if (findDog.id != null) {
      _items.removeWhere((key, value) => value.id == findDog.id);
      notifyListeners();
    }
  }
}
