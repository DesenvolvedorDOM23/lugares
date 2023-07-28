import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplace/providers/great_place.dart';
import 'package:greatplace/share/widget/image_input.dart';
import 'package:greatplace/share/widget/location_input.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _titlecontroller = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectedPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isvalidForm() {
    return _titlecontroller.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isvalidForm()) return;

    Provider.of<GreatPlace>(context, listen: false).addiPlace(
      _titlecontroller.text,
      _pickedImage!,
      _pickedPosition!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo lugar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _titlecontroller,
                    decoration: const InputDecoration(labelText: 'Titulo'),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    _selectedImage,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectedPosition)
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            style: const ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.amber),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: MaterialStatePropertyAll<double>(0),
            ),
            onPressed: _isvalidForm() ? _submitForm : null,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
          )
        ],
      ),
    );
  }
}
