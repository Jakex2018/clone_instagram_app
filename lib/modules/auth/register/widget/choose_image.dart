import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({super.key, required this.onImageSelected});
  final Function(File?) onImageSelected;

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  File? file;
  void onPicker() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'webp']);

    if (result == null) return;

    setState(() {
      file = File(result.files.single.path!);
    });

    widget.onImageSelected(file);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onPicker,
            child: const Row(
              children: [
                Icon(Icons.image),
                Text('Select Image'),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.black26,
            radius: 30,
            child: file != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      file!,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text(
                    // Si no se ha seleccionado ninguna imagen, muestra el texto
                    'No Image',
                    style: TextStyle(fontSize: 7),
                  ),
          ),
        ],
      ),
    );
  }
}
