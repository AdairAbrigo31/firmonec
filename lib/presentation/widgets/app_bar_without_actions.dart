
import 'package:flutter/material.dart';

class AppBarWithoutActions extends StatelessWidget {
  final String title;
  final bool activeBack;
  const AppBarWithoutActions({super.key, required this.title, required this.activeBack});


  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: activeBack,
    );
  }


}