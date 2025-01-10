
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final void Function() onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.blue,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.black)),
      )
    );


  }



}