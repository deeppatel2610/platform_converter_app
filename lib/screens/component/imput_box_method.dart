import 'package:flutter/material.dart';

Card inputBoxMethod({
  required String text,
  required var controller,
  required bool isMaxLines,
  required bool isNumber,
}) {
  return Card(
    color: Colors.blue.shade50,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
        controller: controller,
        maxLines: (isMaxLines) ? 2 : 1,
        decoration: InputDecoration(border: InputBorder.none, hintText: text),
      ),
    ),
  );
}
