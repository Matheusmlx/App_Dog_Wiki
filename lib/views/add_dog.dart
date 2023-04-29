import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customTextField.dart';
import '../models/DescriptionsDog.dart';
import '../models/dog.dart';
import '../provider/dogs.dart';
import '../routes/app_routes.dart';

class AddDog extends StatefulWidget {
  AddDog({super.key});

  final _form = GlobalKey<FormState>();
  var dogItem = const Dog();

  @override
  State<AddDog> createState() => AddDogState();
}

class AddDogState extends State<AddDog> {
  String valueAdd = "";
  bool isLoading = true;
  String? itemId;

  List<DescriptionsDog> newAttributes = <DescriptionsDog>[
    DescriptionsDog(
      id: 0,
      icon: Icons.pets,
      active: false,
      description: "Bagunceiro",
    ),
    DescriptionsDog(
      id: 1,
      icon: Icons.school,
      active: false,
      description: "Desciplinado",
    ),
    DescriptionsDog(
      id: 2,
      icon: Icons.diversity_1,
      active: false,
      description: "Social",
    ),
    DescriptionsDog(
      id: 3,
      icon: Icons.mood,
      active: false,
      description: "Alegre",
    ),
    DescriptionsDog(
        id: 4,
        icon: Icons.record_voice_over,
        active: false,
        description: "Barulhento"),
    DescriptionsDog(
        id: 5,
        icon: Icons.nightlight,
        active: false,
        description: "Preguiçoso"),
    DescriptionsDog(
        id: 6, icon: Icons.water_drop, active: false, description: "AguaFobia"),
    DescriptionsDog(
        id: 7,
        icon: Icons.sports_baseball,
        active: false,
        description: "Brincalhão"),
    DescriptionsDog(
        id: 8, icon: Icons.sick, active: false, description: "Fragil"),
    DescriptionsDog(
        id: 9,
        icon: Icons.safety_divider_sharp,
        active: false,
        description: "Anti Social"),
    DescriptionsDog(
        id: 10,
        icon: Icons.severe_cold,
        active: false,
        description: "Friorento"),
    DescriptionsDog(
        id: 11, icon: Icons.pool, active: false, description: "Gosta de nadar")
  ];

  void setNewAttributes(DescriptionsDog descriptionsDog) {
    setState(() {
      newAttributes[descriptionsDog.id!] = descriptionsDog;
    });
  }

  void isEditing() {
    Object? dogArgs = ModalRoute.of(context)?.settings.arguments;
    if (dogArgs != null && isLoading) {
      Dog findDog = Provider.of<Dogs>(context, listen: false)
          .byIndex(int.parse(dogArgs.toString()));

      widget.dogItem = findDog;

      if (widget.dogItem.caracteristicas.isNotEmpty) {
        List<DescriptionsDog> copyNewAttributes = newAttributes;

        copyNewAttributes.asMap().forEach((key, value) {
          DescriptionsDog? findData = widget.dogItem.caracteristicas.firstWhere(
              (element) => element!.icon == value.icon,
              orElse: () => DescriptionsDog());

          if (findData!.icon != null) {
            newAttributes[key] = DescriptionsDog(
                id: value.id,
                description: value.description,
                icon: value.icon,
                active: true);
          }
        });

        setState(() {
          isLoading = false;
          itemId = findDog.id;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    isEditing();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 131, 236, 245),
        appBar: AppBar(
            title: widget.dogItem.id != null
                ? const Text("Editando Cachorro")
                : const Text('Novo Cachorro')),
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
                                initialValue: widget.dogItem.name,
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
                              CustomTextField(
                                onSaved: (text) => widget.dogItem =
                                    widget.dogItem.copyWith(description: text),
                                title: "Descrição",
                                initialValue: widget.dogItem.description,
                                maxLength: 200,
                                maxLines: 4,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo Obrigátorio";
                                  }

                                  return null;
                                },
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
                                      List<DescriptionsDog> listNewItens =
                                          newAttributes
                                              .where((element) =>
                                                  element.active == true)
                                              .toList();

                                      if (listNewItens.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.orange[400],
                                            content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const <Widget>[
                                                  Text(
                                                      'Adicione pelo menos uma caracteristica!'),
                                                  Icon(
                                                    Icons.warning,
                                                    color: Colors.white,
                                                  )
                                                ]),
                                            duration: const Duration(
                                                milliseconds: 1500),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        );
                                      }

                                      widget.dogItem = widget.dogItem.copyWith(
                                          caracteristicas: listNewItens);

                                      if (widget._form.currentState!
                                              .validate() &&
                                          listNewItens.isNotEmpty) {
                                        widget._form.currentState!.save();
                                        await Provider.of<Dogs>(context,
                                                listen: false)
                                            .put(Dog(
                                          id: itemId,
                                          name: widget.dogItem.name,
                                          description:
                                              widget.dogItem.description,
                                          caracteristicas:
                                              widget.dogItem.caracteristicas,
                                          photo: widget.dogItem.photo,
                                        ));
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.DOG_LIST);
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
  final DescriptionsDog dataActive;
  final Function(DescriptionsDog) setNewAttributes;

  const CheckboxListTileCustom(
      {Key? key, required this.dataActive, required this.setNewAttributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: () {
          setNewAttributes(DescriptionsDog(
              id: dataActive.id,
              icon: dataActive.icon,
              active: !dataActive.active!,
              description: dataActive.description));
        },
        child: Card(
          color: dataActive.active! ? Colors.blue[800] : Colors.white,
          child: Tooltip(
            message: dataActive.description,
            child: Icon(
              dataActive.icon,
              color: dataActive.active! ? Colors.white : Colors.blue[800],
            ),
          ),
        ),
      ),
    );
  }
}
