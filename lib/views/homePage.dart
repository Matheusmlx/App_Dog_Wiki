import 'package:dog_wiki/components/button.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/fundo.png"),
                  fit: BoxFit.cover)),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                const Text("Dog Wiki",
                    style: TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 10, 90, 124),
                        fontFamily: 'Holtwood One SC',
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                const Button(ButtonProps(
                    title: 'Entrar', color: Color.fromARGB(255, 216, 138, 47))),
                Image.asset(
                  'lib/assets/cao_home.png',
                  width: 230,
                  height: 230,
                ),
              ]))),
    );
  }
}
