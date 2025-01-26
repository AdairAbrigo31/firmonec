
import 'package:flutter/material.dart';

class AppBarFirmonec extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final bool showBackButton;

  const AppBarFirmonec ({
    super.key,
    required this.title,
    required this.showBackButton
  });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(

      leading: showBackButton ? IconButton(
        
        onPressed: () {}, 
        
        icon: const Icon(Icons.arrow_back_ios_new_outlined)
      ) : null ,

      title: Align(
        alignment: Alignment.center, 
        child: Text(title), 
        
      )
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}