import 'dart:ui';

import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controllerField;
  final String label;
  final String hint;
  final IconData? icon;

  Editor({
    required this.controllerField,
    required this.label,
    required this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
        controller: controllerField,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            )
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
