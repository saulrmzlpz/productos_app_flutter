import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
          {required String labelText,
          required String hintText,
          IconData? prefixIcon}) =>
      InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null);
}
