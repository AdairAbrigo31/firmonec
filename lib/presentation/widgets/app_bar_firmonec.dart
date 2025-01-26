
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

      title: Align(
        
        alignment: Alignment.center, 
        
        child: Text(
          
          title, 
          
          style: TextStyle(
            
            fontSize: 18, 
            
            color: Theme.of(context).colorScheme.surface,

            letterSpacing: 0.5,
            
          ),

          
          
        )
        
      ),

      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}