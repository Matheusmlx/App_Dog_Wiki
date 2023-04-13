import 'package:dog_wiki/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dogs.dart';

class DogList extends StatefulWidget {
  const DogList({super.key});

  @override
  State<DogList> createState() => _MyWidgetState();  
}

class _MyWidgetState extends State<DogList> {
  @override
  Widget build(BuildContext context) {

    final Dogs dogs = Provider.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 131, 236, 245),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(children: [
                const SizedBox(
                width: 300,
                child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Raças De Cachorros",
                  style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Holtwood One SC',
                  fontWeight: FontWeight.bold)
                  ),
              ),
              ),
              IconButton(
                onPressed: () {
                   Navigator.of(context).pushNamed(
                    AppRoutes.DOG_ADD
                  );
                },
                icon: const Icon(
                  size: 50,
                  color:Colors.blue,
                  Icons.add_circle
                  ))
              ])
            ],
          ),
          Expanded(
            flex: 9,
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3
                    ),
                    itemCount: 9,
                    itemBuilder: (_, int index) => Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Center(child:
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.DOG_ITEM,
                            arguments: dogs.byIndex(index)
                          );
                        },
                        child: Image.asset(
                          dogs.byIndex(index).photo,
                           width: 130),
                      )
                        ),
                    ) ,
                    )),
              ),)
        ]),)
        );
    }}