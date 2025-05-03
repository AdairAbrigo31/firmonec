import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class GetDocumentsNotSentController {
  static Future<void> getDocumentsNotSent(
      BuildContext context, WidgetRef ref) async {
    final repository = ref.read(repositoryProvider);

    final roles =
        ref.read(rolDocumentsProvider).documentsByRol?.keys.toList() ?? [];

    final documentsSentProv = ref.read(documentsNotSentProvider.notifier);

    try {
      LoadingModal.show(context);

      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;

      if (!hasInternet) {
        throw ("Revisar su conexión a internet");
      }

      for (final rol in roles) {
        final List<DocumentNotSent> documentsNotSent =
            await repository.getDocumentsNotSent(rol.codusuario);

        print(documentsNotSent);

        documentsSentProv.addDocumentNotSentToRol(rol, documentsNotSent);
      }
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      LoadingModal.hide(context);
    }
  }
}
