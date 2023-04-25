import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customTextField.dart';
import '../models/dog.dart';
import '../provider/dogs.dart';

class IconDataActive {
  final int? id;
  final IconData? icon;
  final bool? active;

  IconDataActive({this.id, this.icon, this.active});

  IconDataActive copyWith({IconData? icon, bool? active}) {
    return IconDataActive(icon: this.icon, active: this.active);
  }
}

class AddDog extends StatefulWidget {
  AddDog({super.key});

  final _form = GlobalKey<FormState>();
  var dogItem = const Dog();

  @override
  State<AddDog> createState() => AddDogState();
}

class AddDogState extends State<AddDog> {
  String valueAdd = "";
  List<IconDataActive> newAttributes = <IconDataActive>[
    IconDataActive(id: 0, icon: Icons.pets, active: false),
    IconDataActive(id: 1, icon: Icons.school, active: false),
    IconDataActive(id: 2, icon: Icons.diversity_1, active: false),
    IconDataActive(id: 3, icon: Icons.mood, active: false),
    IconDataActive(id: 4, icon: Icons.record_voice_over, active: false),
    IconDataActive(id: 5, icon: Icons.nightlight, active: false),
    IconDataActive(id: 6, icon: Icons.water_drop, active: false),
    IconDataActive(id: 7, icon: Icons.sports_baseball, active: false),
    IconDataActive(id: 8, icon: Icons.sick, active: false),
    IconDataActive(id: 9, icon: Icons.safety_divider_sharp, active: false),
    IconDataActive(id: 10, icon: Icons.severe_cold, active: false),
    IconDataActive(id: 11, icon: Icons.pool, active: false)
  ];

  void setNewAttributes(IconDataActive iconDataActive) {
    setState(() {
      newAttributes[iconDataActive.id!] = iconDataActive;
    });
  }

  // void addNewAttributes(IconDataActive newIconAdd) {
  //   IconDataActive? newDataActive = newAttributes.firstWhere(
  //     (element) => element!.id == newIconAdd.id,
  //     orElse: () {
  //       newAttributes.add(IconDataActive(
  //           id: newIconAdd.id, icon: newIconAdd.icon, active: true));
  //       return null;
  //     },
  //   );

  //   if (newDataActive != null) {
  //     int newDataActiveIndex = newAttributes.indexOf(newDataActive);

  //     newAttributes[newDataActiveIndex] = IconDataActive(
  //         id: newDataActiveIndex, icon: newDataActive.icon, active: false);
  //   }

  //   print(newAttributes[0]!.active);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 131, 236, 245),
        appBar: AppBar(title: const Text('Novo Cachorro')),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(
              builder: (_, constrains) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsetsDirectional.only(top: 30),
                        width: constrains.maxWidth / 1.1,
                        child: Form(
                          key: widget._form,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomTextField(
                                onSaved: (text) => widget.dogItem =
                                    widget.dogItem.copyWith(name: text),
                                title: "Nome",
                                maxLength: 30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo Obrigátorio";
                                  }

                                  if (value.length < 3) {
                                    return "Valor minimo exigido deve ser maior que 3";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                title: "Raça",
                                onSaved: (text) => widget.dogItem =
                                    widget.dogItem.copyWith(photo: text),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo Obrigátorio";
                                  }

                                  if (value.length < 3) {
                                    return "Valor minimo exigido deve ser maior que 3";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                onSaved: (text) => widget.dogItem =
                                    widget.dogItem.copyWith(description: text),
                                title: "Descrição",
                                maxLength: 200,
                                maxLines: 4,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: const <Widget>[
                                    Text(
                                      "Caracteristicas",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 65,
                                  child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1),
                                      itemCount: newAttributes.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CheckboxListTileCustom(
                                          setNewAttributes: setNewAttributes,
                                          dataActive: newAttributes[index],
                                        );
                                      })),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 60, 220, 124)),
                                    onPressed: () async {
                                      if (widget._form.currentState!
                                          .validate()) {
                                        widget._form.currentState!.save();
                                        await Provider.of<Dogs>(context,
                                                listen: false)
                                            .put(Dog(
                                                id: null,
                                                name: widget.dogItem.name,
                                                description:
                                                    widget.dogItem.description,
                                                photo: widget.dogItem.photo));
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    icon: const Icon(Icons.save),
                                    label: const Text("Salvar",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              )
                            ],
                          ),
                        )),
                  ],
                );
              },
            )));
  }
}

class CheckboxListTileCustom extends StatelessWidget {
  final IconDataActive dataActive;
  final Function(IconDataActive) setNewAttributes;

  const CheckboxListTileCustom(
      {Key? key, required this.dataActive, required this.setNewAttributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: () {
          setNewAttributes(IconDataActive(
              id: dataActive.id,
              icon: dataActive.icon,
              active: !dataActive.active!));
        },
        child: Card(
          color: dataActive.active! ? Colors.blue[800] : Colors.white,
          child: Icon(
            dataActive.icon,
            color: dataActive.active! ? Colors.white : Colors.blue[800],
          ),
        ),
      ),
    );
  }
}
