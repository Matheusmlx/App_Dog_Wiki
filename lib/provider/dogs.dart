import 'package:dog_wiki/data/dummy_dogs.dart';
import 'package:dog_wiki/models/dog.dart';
import 'package:flutter/material.dart';

class Dogs with ChangeNotifier {
  final Map<String, Dog> _items = {...DUMMY_DOGS};

  get all {
    return [..._items.values];
  }

  Dog byIndex(int i) {
    return _items.values.elementAt(i);
  }
}