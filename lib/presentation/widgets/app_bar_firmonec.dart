
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tesis_firmonec/theme/app_typography.dart';

class AppBarFirmonec extends StatelessWidget implements PreferredSizeWidget{

  final String title;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;

  const AppBarFirmonec ({
    super.key,
    required this.title,
    this.automaticallyImplyLeading,
    this.actions
  });
  
  @override
  Widget build(BuildContext context) {

    return AppBar(
      centerTitle: true,

      backgroundColor: Theme.of(context).primaryColor,

      automaticallyImplyLeading: automaticallyImplyLeading ?? true,

      leading: SidebarX(
        
        controller: SidebarXController(selectedIndex: 0), 
        
        items: [

          SidebarXItem(
            icon: Icons.home,
            label: 'Pendientes',
            onTap: () {
              // Si a se encuentra en esta vista no hacer nada
            },  
          ),

          SidebarXItem(
            icon: Icons.check,
            label: 'Enviador',
            onTap: () {
              // Si a se encuentra en esta vista no hacer nada
            },  
          ),

          SidebarXItem(
            icon: Icons.error,
            label: 'No enviados',
            onTap: () {
              // Si a se encuentra en esta vista no hacer nada
            },  
          )
        ]),

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