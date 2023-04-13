import 'package:dog_wiki/components/customTextField.dart';
import 'package:dog_wiki/models/dog.dart';
import 'package:flutter/material.dart';

class AddDog extends StatelessWidget {
  AddDog({super.key});

  final _form = GlobalKey<FormState>();
  var dogItem = const Dog();

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
                          key: _form,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomTextField(
                                onSaved: (text) =>
                                    dogItem = dogItem.copyWith(name: text),
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
                                onSaved: (text) =>
                                    dogItem = dogItem.copyWith(photo: text),
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
                                onSaved: (text) => dogItem =
                                    dogItem.copyWith(description: text),
                                title: "Descrição",
                                maxLength: 200,
                                maxLines: 4,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_form.currentState!.validate()) {
                                        _form.currentState!.save();
                                        print('''Item para ser Salvo
                                          Nome: ${dogItem.name},
                                          Description: ${dogItem.description},
                                          Photo: ${dogItem.photo},
                                        ''');
                                      }
                                    },
                                    icon: const Icon(Icons.save),
                                    label: const Text("Salvar")),
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
