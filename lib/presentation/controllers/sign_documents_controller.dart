import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/exceptions/request_failed_exception.dart';
import 'package:tesis_firmonec/infrastructure/repositories/repositories.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';


class SignDocumentsController {


  static Future<List<ResponseSignDocument>> _signDocumentBatch( SignBatchData batchData ) async {

    final RepositoryFirmonecImplementation repository = RepositoryFirmonecImplementation();

    final results = <ResponseSignDocument>[];

    for (final docId in batchData.documentIds) {

      try {

        final response = await repository.signDocument(
          
          idDocument: docId, 
          
          codeUser: batchData.codeUser, 
          
          base64Certificate: batchData.base64Certificate, 
          
          keyCertificate: batchData.keyCertificate
          
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

        throw ("$e");
      }
    }

    return results;

  }




  static Map<String, dynamic> _processResults (List<ResponseSignDocument> results) {

    final success = results.where((element) => element.success).length;
    final errors = results.where((element) => !element.success).length;

    return {
      'success': success,
      'errors': errors,
      'total': results.length
    };

  }

  


  static Future<Map<String, dynamic>> signDocuments(BuildContext context, WidgetRef ref) async {

    try {

      LoadingModal.show(context);

      final documentsSelected = ref.read(documentSelectedProvider);

      final certificate = documentsSelected.certificate;

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
          codeUser: int.parse( rol.codusuario ),
          documentIds: documents.map((e) => e.id).toList(),
          base64Certificate: certificate!.base64,
          keyCertificate: keyCertificate,
        );      

        // Crear un isolate para cada rol
        allSigningFutures.add(

          Isolate.run(() => _signDocumentBatch(batchData))
          
        );

      }

      final batchResults = await Future.wait(allSigningFutures);

      final results =  batchResults.expand( (batch) => batch ).toList();

      final resultsProcessed = _processResults(results);

      
      //Alamacenar los resultados para la pantalla de retroalimentación

      ref.read(resultsDocumentsSignedProvider.notifier).update((old) => resultsProcessed);

      return resultsProcessed;
      
    } on RequestFailedException catch (error) {

      print("$error");

      rethrow;


    } finally {

      if(context.mounted) {

        LoadingModal.hide(context);

      }
            
    }

  }


}