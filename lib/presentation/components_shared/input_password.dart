
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final Function(String) onChange;

  const InputPassword({super.key, required this.onChange});

  @override
  State<InputPassword> createState() => InputPasswordState();

}

class InputPasswordState extends State<InputPassword>{

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => widget.onChange(value),
      keyboardType: TextInputType.visiblePassword,
    );
  }

}