
import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {
  final String example;
  final Function(String) onChange;
  const InputEmail({super.key, required this.example, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: example,
        hintStyle: const TextStyle(color: Colors.black)
      ),
      onChanged: (value) => onChange(value),
      keyboardType: TextInputType.emailAddress,
    );
  }

}