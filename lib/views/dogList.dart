import 'package:dog_wiki/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dogs.dart';

class DogList extends StatelessWidget {
  const DogList({super.key});

  @override
  Widget build(BuildContext context) {
    final Dogs dogs = Provider.of(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 131, 231, 255),
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 290,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text("Raças De Cachorros",
                        style: TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Holtwood One SC',
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                dogs.size > 0
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.DOG_ADD);
                        },
                        icon: const Icon(
                            size: 50,
                            color: Color.fromARGB(255, 18, 162, 181),
                            Icons.add_circle))
                    : const SizedBox()
              ],
            ),
            dogs.size < 1
                ? Container(
                    margin: const EdgeInsets.only(top: 45),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'lib/assets/sad.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text(
                          "Lista Vazia",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Holtwood One SC',
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                            child: const Text("Adicionar"),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.DOG_ADD);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    flex: 9,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: dogs.size,
                            itemBuilder: (_, int index) => Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.DOG_ITEM,
                                      arguments: dogs.byIndex(index));
                                },
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(dogs.byIndex(index).photo),
                                  //fit: BoxFit.cover,
                                ),
                              )),
                            ),
                          )),
                    ),
                  )
          ]),
        ));
  }
}
