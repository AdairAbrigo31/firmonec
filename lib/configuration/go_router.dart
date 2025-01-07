

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/presentation/screens/screens.dart';

final navigatorKey = GlobalKey<NavigatorState>();


final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/quipux_saved',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (contex, state) => const LoginScreen(),
      ),

      GoRoute(
        name: 'quipux_saved',
        path: '/quipux_saved',
        builder: (context, state) => const QuipuxSavedScreen(),
      ),

      GoRoute(
          name: 'login_quipux',
          path: '/login_quipux',
        builder: (context, state) => const LoginQuipuxScreen()
      ),

      GoRoute(
        name: 'roles_documents_quipux',
        path: '/roles_documents_quipux',
        builder: (context, state) => const RolesDocumentsQuipuxScreen(),
      ),

      GoRoute(
        name: 'preview_document_selected',
        path: '/preview_document_selected',
        builder: (context, state) => const PreviewDocumentsSelectedScreen(),
      )
    ]
);