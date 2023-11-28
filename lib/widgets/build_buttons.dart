import '../models/buttons.dart';
import '../themes/bottuns_colors.dart';
import 'package:flutter/material.dart';

Widget buildButtons(value) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      color: getButtonColor(value),
      clipBehavior: Clip.hardEdge,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white24
        ),
        borderRadius: BorderRadius.circular(100)
      ),
      child: InkWell(
        onTap: () => onButtonTap(value),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0
            ),
            ),
          ),
      ),
    ),
  );
}

void onButtonTap(String value) {
  numberOne;
}