// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart ' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  Function onselectedImage;
  ImageInput(
    this.onselectedImage, {
    super.key,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storageImage;

  _takepicture() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      ) as XFile;
      setState(() {
        if (imageFile != null) {
          _storageImage = File(imageFile.path);
        } else {
          return;
        }
      });
      final appdir = await syspath.getApplicationDocumentsDirectory();
      String filename = path.basename(_storageImage!.path);
      final saveImage = await _storageImage!.copy(
        '${appdir.path}/$filename',
      );
      widget.onselectedImage(saveImage);
    } catch (e) {
      throw Exception('sem foto !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: Alignment.center,
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storageImage != null
                ? Image.file(
                    _storageImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Text('Nenhuma Imagem')),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takepicture,
            icon: const Icon(Icons.camera),
            label: const Text('tirar foto !'),
          ),
        )
      ],
    );
  }
}
