
import 'package:flutter/material.dart';

class AppBarWithActions extends StatelessWidget {
  final String title;
  final bool isActiveBack;
  const AppBarWithActions({super.key, required this.title ,required this.isActiveBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: isActiveBack,
      actions: [],
    );
  }


}