import 'dart:isolate';

import 'package:dio/dio.dart';
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

    } else {

      final dio = Dio(
        BaseOptions(
          baseUrl: "",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10)
        )
      );

      //En caso de poder firmar multiples archivos
      await Isolate.run(() {

        dio.post("path", data: {
          "rol" : "",
          "document": "document",
          "cetificado": "certificado"
        });

      });

    }

  }
}