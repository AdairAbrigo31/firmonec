import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/signed/documents_selected_provider.dart';

class SignDocumentsController {

  static Future<void> handleSignDocuments(BuildContext context, WidgetRef ref, CertificateEntity certificate) async {

    final documentsSelected = ref.read(documentSelectedProvider);

    if (documentsSelected.totalDocuments == 0) {

      print("No hay documentos que firmar");
      return;

    }
    //LLAMAR AL ENDPOINT PARA FIRMAR

  }
}