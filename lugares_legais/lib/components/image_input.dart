import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.selectedImage});

  final Function(File file) selectedImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? file =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (file == null) return;

    setState(() {
      _storedImage = File(file.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.selectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma imagem!'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () => _takePicture(),
            label: const Text('Tirar foto'),
            icon: const Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}
