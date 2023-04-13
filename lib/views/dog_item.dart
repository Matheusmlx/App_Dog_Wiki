import 'package:dog_wiki/models/dog.dart';
import 'package:flutter/material.dart';

import '../components/dog_item_attr.dart';

class Dog_Item extends StatelessWidget {

  final Map<String, String> _formData = {};

  Dog_Item({super.key});

  void _loadDogs(Object? dogs) {
    if (dogs != null && dogs is Dog){
      _formData['id'] = dogs.id!;
      _formData['name'] = dogs.name;
      _formData['description'] = dogs.description;
      _formData['photo'] = dogs.photo;
    }
  }

  @override
  Widget build(BuildContext context) {

    final dogsArgs = ModalRoute.of(context)?.settings.arguments;

    _loadDogs(dogsArgs);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 131, 236, 245),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).pop()
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    ),
                ),
                Text(
                _formData['name'].toString(),
                style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'Holtwood One SC',
                    fontWeight: FontWeight.bold)
                ),
                const Text('')
            ],),
            SizedBox(
              height: 275,
              width: 300,
              child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                _formData['photo'].toString(),
                height: 180),
            ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(_formData['description'].toString())),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded( child:
                   Dog_Item_Attr( 'Divertido', Icons.pets)
                  ),
                  Expanded( child: 
                   Dog_Item_Attr( 'Inteligente', Icons.school)
                  ),
                 Expanded( child:
                   Dog_Item_Attr( 'Social', Icons.diversity_1)
                  ),
                  Expanded( child:
                   Dog_Item_Attr( 'Animado', Icons.mood)
                  ),
                ],
    ),
          ]))),
    );
  }
}