import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class ButtonProps {
  final String title;
  final Color color;

  const ButtonProps({
    required this.title,
    required this.color
  });
}

class Button extends StatelessWidget {

  final ButtonProps props;

  const Button(this.props, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.DOG_LIST);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 40,
                    ),
                ),
              backgroundColor: MaterialStateProperty.all<Color>(props.color)
            ),
            child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(props.title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'Holtwood One SC',
                  fontWeight: FontWeight.bold
                ),
                )
              ),
          );
  }
}