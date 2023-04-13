import 'package:dog_wiki/provider/dogs.dart';
import 'package:dog_wiki/routes/app_routes.dart';
import 'package:dog_wiki/views/add_dog.dart';
import 'package:dog_wiki/views/dogList.dart';
import 'package:dog_wiki/views/dog_item.dart';
import 'package:dog_wiki/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Dogs(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.HOME: (_) => HomePage(),
            AppRoutes.DOG_LIST: (_) => DogList(),
            AppRoutes.DOG_ITEM: (_) => Dog_Item(),
            AppRoutes.DOG_ADD: (_) => AddDog()
          }),
    );
  }
}
