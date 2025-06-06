import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/presentation/screens/screens.dart';
import 'package:tesis_firmonec/presentation/screens/signed/documents_not_sent_screen.dart';
import 'package:tesis_firmonec/presentation/screens/signed/documents_sent_screen.dart';
import 'package:tesis_firmonec/presentation/screens/signed/documents_signed_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login_quipux',
    routes: [
      GoRoute(
        name: 'login_entraID',
        path: '/login_entraID',
        builder: (context, state) => const LoginWithEntraIDScreen(),
      ),
      GoRoute(
          name: 'login_quipux',
          path: '/login_quipux',
          builder: (context, state) => const LoginQuipuxScreen()),
      GoRoute(
        name: 'roles_documents_quipux',
        path: '/roles_documents_quipux',
        builder: (context, state) => const RolesWithDocumentsScreen(),
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
      ),
      GoRoute(
        name: 'documents_signed',
        path: '/documents_signed',
        builder: (context, state) => const DocumentsSignedScreen(),
      ),
      GoRoute(
        name: 'documents_sent',
        path: '/documents_sent',
        builder: (context, state) => const DocumentsSentScreen(),
      ),
      GoRoute(
        name: 'documents_not_sent',
        path: '/documents_not_sent',
        builder: (context, state) => const DocumentsNotSentScreen(),
      ),
      GoRoute(
        name: 'preview_documents_sent',
        path: '/preview_documents_sent',
        builder: (context, state) => const PreviewDocumentSentScreen(),
      ),
      GoRoute(
        name: 'preview_documents_not_sent',
        path: '/preview_documents_not_sent',
        builder: (context, state) => const PreviewDocumentNotSentScreen(),
      ),
    ]);
