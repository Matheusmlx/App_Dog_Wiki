import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final int? maxLength;
  final int? maxLines;

  const CustomTextField(
      {Key? key,
      required this.title,
      this.validator,
      this.onSaved,
      this.maxLength,
      this.maxLines})
      : super(key: key);

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool active = false;

  final myController = TextEditingController();

  void _activeCampo(String value) {
    if (value.isNotEmpty) {
      setState(() {
        active = true;
      });
    } else {
      setState(() {
        active = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      maxLength: widget.maxLength ?? 20,
      maxLines: widget.maxLines ?? 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey, width: 4)),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.title,
          hintText: "Digitando....",
          suffixIcon: active
              ? IconButton(
                  onPressed: () => {
                        myController.clear(),
                        setState(() {
                          active = false;
                        })
                      },
                  icon: Icon(
                    Icons.close,
                    color: Colors.red[400],
                  ))
              : null,
          suffixIconColor: Colors.red[400]),
      onChanged: _activeCampo,
    );
  }
}
