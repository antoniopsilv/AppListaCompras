import 'package:flutter/material.dart';

class cell extends StatelessWidget {


final String title;
final String hint;
final TextEditingController controller;

cell(this.title, this.hint, this.controller);

  @override
  Widget build(BuildContext) {
    return
      TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        keyboardType: TextInputType.text,
      );
    }
}