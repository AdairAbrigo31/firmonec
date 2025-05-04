import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/go_router.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class CloseSessionController {
  static Future<void> closeSession(BuildContext context, WidgetRef ref) async {
    try {
      LoadingModal.show(context);
      ref.read(oneDocumentSelectedPreviewProvider.notifier).clearDocument();
      ref.read(documentSelectedProvider.notifier).clearAllDocuments();
      ref.read(rolDocumentsProvider.notifier).clearAllDocuments();
    } catch (error) {
      print("Error closing session: $error");
      throw ("$error");
    } finally {
      LoadingModal.hide(context);
      router.goNamed("login_quipux");
    }
  }
}
