import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [TextFormField(
              decoration: const InputDecoration(label: Text('Nome')),
              textInputAction: TextInputAction.next,
            )],
          ),
        ),
      ),
    );
  }
}