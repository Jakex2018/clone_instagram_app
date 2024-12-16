import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 14),
      height: 70,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
