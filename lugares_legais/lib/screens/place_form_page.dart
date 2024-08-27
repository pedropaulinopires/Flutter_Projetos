import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lugares_legais/components/image_input.dart';
import 'package:lugares_legais/components/location_input.dart';
import 'package:lugares_legais/provider/greate_places.dart';
import 'package:provider/provider.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({super.key});

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectedImage(File file) {
    _pickedImage = file;
  }

  void _submiForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatePlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo lugar'),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Título'),
                        ),
                        controller: _titleController,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ImageInput(selectedImage: _selectedImage),
                      const SizedBox(
                        height: 25,
                      ),
                      const LocationInput()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _submiForm(),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar'),
                    ),
                  ),
                ],
              ))
        ]));
  }
}
