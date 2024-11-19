import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
