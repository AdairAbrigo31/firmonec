

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/presentation/screens/screens.dart';

final navigatorKey = GlobalKey<NavigatorState>();


final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/login_quipux',
    routes: [
      GoRoute(
        name: 'button_entraid',
        path: '/button_entraid',
        builder: (context, state) => const LoginWithEntraIDScreen(),
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
        name: 'preview_one_document',
        path: '/preview_one_document',
        builder: (context, state) => const PreviewOneDocumentScreen(),
      ),

      GoRoute(
        name: 'preview_all_documents_selected',
        path: '/preview_all_documents_selected',
        builder: (context, state) => const PreviewAllDocumentsSelectedScreen(),
      ),

      GoRoute(
        name: 'certificates_for_sign',
        path: '/certificates_for_sign',
        builder: (context, state) => const CertificatesForSignScreen(),
      )
    ]
);