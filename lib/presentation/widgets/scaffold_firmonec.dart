import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/controllers/close_session_controller.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/login/user_active_provider.dart';
import 'widgets.dart';

class ScaffoldFirmonec extends ConsumerStatefulWidget {
  final String title;
  final Widget children;
  final int initialSelectedIndex;

  const ScaffoldFirmonec({
    super.key,
    required this.title,
    required this.children,
    this.initialSelectedIndex = 0,
  });

  @override
  ConsumerState<ScaffoldFirmonec> createState() => _ScaffoldFirmonecState();
}

class _ScaffoldFirmonecState extends ConsumerState<ScaffoldFirmonec> {
  late final SidebarXController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        SidebarXController(selectedIndex: widget.initialSelectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userActiveProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          widget.title,
          style: TextStyle(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        iconTheme: IconThemeData(
          color: theme.colorScheme.surface, // Cambia este color al que desees
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  LoadingModal.show(context);
                  await GetInformationUserController
                      .refreshDataQuipuxWithoutToken(ref, context);
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $error')));
                  }
                } finally {
                  LoadingModal.hide(context);
                }
                if (context.mounted) router.goNamed("roles_documents_quipux");
              },
              icon: Icon(
                Icons.refresh_outlined,
                color: theme.colorScheme.surface,
              ))
        ],
      ),
      drawer: SidebarX(
        controller: SidebarXController(
            selectedIndex: widget.initialSelectedIndex, extended: true),
        extendedTheme: SidebarXTheme(
          width: 200,
          textStyle: TextStyle(color: theme.primaryColor), // Color normal
          selectedTextStyle:
              TextStyle(color: theme.primaryColor), // Color seleccionado
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemDecoration: BoxDecoration(
            color: theme.disabledColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        headerDivider:
            const Divider(color: Colors.transparent), // Divisor invisible
        animationDuration:
            Duration.zero, // Sin animación para mostrar directamente extendido
        headerBuilder: (context, extended) => Container(
          height: 100,
          color: theme.primaryColor,
          child: Center(
            child: Text(
              user.email!,
              style: TextStyle(
                color: theme.secondaryHeaderColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        items: [
          SidebarXItem(
            icon: Icons.file_present,
            label: 'Por Firmar',
            onTap: () {
              router.goNamed("roles_documents_quipux");
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          SidebarXItem(
            icon: Icons.task_alt,
            label: 'Enviados',
            onTap: () async {
              await GetDocumentsSentController.getDocumentSent(context, ref);
              router.goNamed("documents_sent");
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          SidebarXItem(
            icon: Icons.error_outline,
            label: 'No enviados',
            onTap: () {
              router.goNamed("documents_not_sent");
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          SidebarXItem(
            icon: Icons.logout,
            label: 'Cerrar Sesión',
            onTap: () {
              CloseSessionController.closeSession(context, ref);
            },
          ),
        ],
      ),
      body: widget.children,
    );
  }
}
