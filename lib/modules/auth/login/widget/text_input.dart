import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 201, 199, 199)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFFf2f2f2),
            )),
            filled: true,
            fillColor: Color(0xFFf5f5f5)),
      ),
    );
  }
}
