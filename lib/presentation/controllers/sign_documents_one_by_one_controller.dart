
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class SignDocumentsOneByOneController {


  static Map<String, dynamic> _processResults (List<ResponseSignDocument> results) {

    final success = results.where((element) => element.success).length;
    final errors = results.where((element) => !element.success).length;

    return {
      'success': success,
      'errors': errors,
      'total': results.length
    };

  }


  static Future<void> signDocumentsOneByOneWithoutPasswordSaved (BuildContext context, WidgetRef ref) async {

    LoadingModal.show(context);

    final repository = ref.watch(repositoryProvider);

    final documentsSelected = ref.read(documentSelectedProvider);

    final certificate = documentsSelected.certificate;

    final keyCertificate = documentsSelected.password;

    final documentsForSign = documentsSelected.documentsSelected;

    final results = <ResponseSignDocument>[];

    for ( final rol in documentsForSign.keys ) {

      for ( final document in documentsForSign[rol]! ){

        final response = await repository.signDocument(
          idDocument: document.id, 
          codeUser: int.parse(rol.codusuario), 
          base64Certificate: certificate!.base64, 
          keyCertificate: keyCertificate!
        );

        results.add(response);
      }
    }

    final resultsProcessed =  _processResults(results);

    ref.read(resultsDocumentsSignedProvider.notifier).update((old) => resultsProcessed);

    if ( context.mounted ) {

    LoadingModal.hide(context);

    }

  }

  static Future<void> signDocumentsOneByOneWithPasswordSaved (BuildContext context, WidgetRef ref) async {

    LoadingModal.show(context);

    final repository = ref.watch(repositoryProvider);

    final documentsSelected = ref.read(documentSelectedProvider);

    final certificate = documentsSelected.certificate;

    final documentsForSign = documentsSelected.documentsSelected;

    final results = <ResponseSignDocument>[];

    for ( final rol in documentsForSign.keys ) {

      for ( final document in documentsForSign[rol]! ){

        final response = await repository.signDocument(
          idDocument: document.id, 
          codeUser: int.parse(rol.codusuario), 
          base64Certificate: certificate!.base64, 
          keyCertificate: certificate.password!
        );

        results.add(response);
      }
    }

    final resultsProcessed =  _processResults(results);

    ref.read(resultsDocumentsSignedProvider.notifier).update((old) => resultsProcessed);

    if ( context.mounted ) {

    LoadingModal.hide(context);

    }

  }
}