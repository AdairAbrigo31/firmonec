
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/theme/app_typography.dart';

class AppBarFirmonec extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;

  const AppBarFirmonec ({
    super.key,
    required this.title,
    required this.showBackButton,
    this.automaticallyImplyLeading,
    this.actions
  });
  
  @override
  Widget build(BuildContext context) {

    return AppBar(
      centerTitle: true,

      backgroundColor: Theme.of(context).primaryColor,

      automaticallyImplyLeading: automaticallyImplyLeading ?? true,

      leading: showBackButton ? 
      
      IconButton(
        
        onPressed: () {

          context.pop();

        }, 
        
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: Theme.of(context).colorScheme.surface,),

        color: Theme.of(context).colorScheme.surface,

      ) 

      : 

      null ,

      title: Text(

        title,

        style: AppTypography.h1.copyWith(

          color: Theme.of(context).colorScheme.surface,

        ),
      ),

      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}