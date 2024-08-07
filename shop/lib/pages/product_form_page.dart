import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _urlFocus = FocusNode();
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, Object> _formData = {};

  @override
  void initState() {
    super.initState();
    _urlFocus.addListener(setImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _urlFocus.dispose();
    _urlFocus.removeListener(setImage);
  }

  void setImage() {
    if (!_urlFocus.hasFocus) setState(() {});
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;

    if (!valid) {
      return;
    }

    _formKey.currentState?.save();
    var newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['title'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        actions: [IconButton(onPressed: _submit, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Nome')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (title) => _formData['title'] = title ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome do produto é obrigatório!';
                  } else if (value.length < 3) {
                    return 'O nome do produto teve conter no mínimo 3 caracteres!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Preço')),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocus),
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Descrição')),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text('Url da imagem')),
                      focusNode: _urlFocus,
                      keyboardType: TextInputType.url,
                      controller: _urlController,
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      onFieldSubmitted: (_) => _submit(),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: _urlController.text.isEmpty
                        ? const Text('Imagem')
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              _urlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
