import 'package:dog_wiki/models/dog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/dog_item_attr.dart';
import '../models/DescriptionsDog.dart';
import '../provider/dogs.dart';
import '../routes/app_routes.dart';

class Dog_Item extends StatelessWidget {
  final Map<String, String> _formData = {};
  final List<DescriptionsDog?> inconsData = [];

  Dog_Item({super.key});

  void _loadDogs(Object? dogs) {
    if (dogs != null && dogs is Dog) {
      _formData['id'] = dogs.id!;
      _formData['name'] = dogs.name;
      _formData['description'] = dogs.description;
      _formData['photo'] = dogs.photo;
      inconsData.addAll(dogs.caracteristicas);
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
                          onTap: () => {Navigator.of(context).pop()},
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(_formData['name'].toString(),
                            style: const TextStyle(
                                fontSize: 30,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Holtwood One SC',
                                fontWeight: FontWeight.bold)),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.DOG_ADD,
                                    arguments: _formData["id"])
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.orange[300],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.8),
                                        title: const Text(
                                          "Deseja realmente exlcuir ?",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: const Text(
                                                "Não",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                Provider.of<Dogs>(context,
                                                        listen: false)
                                                    .deleteDog(_formData["id"]
                                                        .toString());
                                                Navigator.of(context).pushNamed(
                                                    AppRoutes.DOG_LIST);
                                              },
                                              child: const Text("Sim",
                                                  style: TextStyle(
                                                      color: Colors.green))),
                                        ],
                                      )),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 275,
                      width: 300,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(_formData['photo'].toString()),
                      ),
                    ),
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_formData['description'].toString())),
                    ),
                    Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1),
                                itemCount: inconsData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Dog_Item_Attr(
                                      inconsData[index]!.description!,
                                      inconsData[index]!.icon!);
                                }))),
                  ]))),
    );
  }
}
