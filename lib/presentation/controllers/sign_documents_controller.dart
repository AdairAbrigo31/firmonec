import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';


class SignDocumentsController {

  static Future<List<ResponseSignDocument>> signDocumentBatch( SignBatchData batchData, WidgetRef ref ) async {

    final repository = ref.read(repositoryProvider);

    final results = <ResponseSignDocument>[];

    for (final docId in batchData.documentIds) {

      try {

        final response = await repository.signDocument(
          docId,
          batchData.codeUser,
          batchData.base64Certificate,
          batchData.keyCertificate,
        );

        results.add(
          response
        );

      } catch (e) {

        results.add(
          ResponseSignDocument(
            success: false,
            documentId: docId,
            error: null
          )
        );
      }
    }

    return results;
  }


  static Future<List<ResponseSignDocument>> handleSignDocuments(BuildContext context, WidgetRef ref, CertificateEntity certificate) async {

    final documentsSelected = ref.read(documentSelectedProvider);

    final repository = ref.read(repositoryProvider);

    final keyCertificate = documentsSelected.password;

    final documentsForSign = documentsSelected.documentsSelected;


    if (documentsSelected.totalDocuments == 0) {
      throw Exception("No hay documentos que firmar");
    }

    if (keyCertificate == null) {
      throw Exception("No se ha proporcionado la clave del certificado");
    }

    final allSigningFutures = <Future<List<ResponseSignDocument>>>[];

    for (final entry in documentsForSign.entries) {

      final rol = entry.key;
      final documents = entry.value;
      
      final batchData = SignBatchData(
        codeUser: rol.codusuario,
        documentIds: documents.map((e) => e.id).toList(),
        base64Certificate: certificate.base64,
        keyCertificate: keyCertificate!,
      );

      

      // Crear un isolate para cada rol
      allSigningFutures.add(

        Isolate.run(() => signDocumentBatch(batchData, ref))
        
      );

    }

    try {

      final batchResults = await Future.wait(allSigningFutures);

      return batchResults.expand( (batch) => batch ).toList();


    } catch (error) {

      throw ("$error");
    }

  }
}