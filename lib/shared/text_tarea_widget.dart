import 'package:flutter/material.dart';

class TextareaWidget extends StatefulWidget {
  const TextareaWidget({super.key});

  @override
  State<TextareaWidget> createState() => _TextareaWidgetState();
}

class _TextareaWidgetState extends State<TextareaWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: _controller,
        maxLines: 10,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: 'Escribe aquí...',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
