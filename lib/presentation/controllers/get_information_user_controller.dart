import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class GetInformationUserController {
  static Future<Map<String, dynamic>?> _executeCompleteLogin(
      WidgetRef ref) async {
    try {
      final repository = ref.read(repositoryProvider);

      final valid = await repository.login();

      print("Paso el login de microsoft exito");

      final responseData = await repository.getTokenBackend(valid.token!);

      print("Paso el login firmonec exito");

      return responseData;
    } catch (error) {
      throw ("$error");
    }
  }

  static Future<void> getDataQuipux(WidgetRef ref, BuildContext context) async {
    try {
      //await LoadingModal.show(context);

      final repository = ref.read(repositoryProvider);

      final responseData = await _executeCompleteLogin(ref);

      if (responseData != null) {
        final userNotifier = ref.read(userActiveProvider.notifier);

        userNotifier.updateUser(
            email: responseData["email"], token: responseData["token"]);

        final stateUserProvider = ref.read(userActiveProvider);

        final List<RolEntity> roles = await repository.getRoles(
            email: stateUserProvider.email!, token: stateUserProvider.token!);

        print("Peticion de roles terminada");

        final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

        rolDocumentProvider.clearAllDocuments();

        for (final rol in roles) {
          final List<DocumentEntity> documentPorElaborar =
              await repository.getDocumentPorElaborar(rol.codusuario);

          //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

          final List<DocumentEntity> documentReasignado = [];

          final allDocuments = [...documentPorElaborar, ...documentReasignado];

          rolDocumentProvider.addDocumentToRol(rol, allDocuments);
        }

        print("Petición de documentos terminada");
      }

      if (!context.mounted) return;

      //await LoadingModal.hide(context);
    } catch (error) {
      //await LoadingModal.hide(context);

      String errorMessage = "Error inesperado";
      if (error.toString().contains("networkError")) {
        errorMessage = "Sin conexión a internet";
      }

      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      rethrow;
    }
  }

  static Future<void> executeActionsWithouToken(
      WidgetRef ref, BuildContext context) async {
    final userProvider = ref.read(userActiveProvider);

    final repository = ref.read(repositoryProvider);

    try {
      LoadingModal.show(context);

      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;

      if (!hasInternet) {
        throw ("Revisar su conexión a internet");
      }

      final List<RolEntity> roles =
          await repository.getRolesWithoutToken(email: userProvider.email!);

      final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

      rolDocumentProvider.clearAllDocuments();

      for (final rol in roles) {
        final List<DocumentEntity> documentPorElaborar =
            await repository.getDocumentPorElaborar(rol.codusuario);

        //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

        final List<DocumentEntity> documentReasignado = [];

        final allDocuments = [...documentPorElaborar, ...documentReasignado];

        rolDocumentProvider.addDocumentToRol(rol, allDocuments);
      }

      if (!context.mounted) return;

      LoadingModal.hide(context);
    } catch (error) {
      if (!context.mounted) return;

      LoadingModal.hide(context);

      rethrow;
    }
  }

  static Future<void> refreshDataQuipux(
      WidgetRef ref, BuildContext context) async {
    try {
      ref.read(documentSelectedProvider.notifier).clearAllDocuments();

      final repository = ref.read(repositoryProvider);

      final stateUserProvider = ref.read(userActiveProvider);

      LoadingModal.show(context);

      final List<RolEntity> roles = await repository.getRoles(
          email: stateUserProvider.email!, token: stateUserProvider.token!);

      final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

      rolDocumentProvider.clearAllDocuments();

      for (final rol in roles) {
        final List<DocumentEntity> documentPorElaborar =
            await repository.getDocumentPorElaborar(rol.codusuario);

        //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

        final List<DocumentEntity> documentReasignado = [];

        final allDocuments = [...documentPorElaborar, ...documentReasignado];

        rolDocumentProvider.addDocumentToRol(rol, allDocuments);
      }
    } catch (error) {
      throw ("$error");
    } finally {
      LoadingModal.hide(context);
    }
  }

  static Future<void> refreshDataQuipuxWithoutToken(
      WidgetRef ref, BuildContext context) async {
    try {
      ref.read(oneDocumentSelectedPreviewProvider.notifier).clearDocument();

      ref.read(documentSelectedProvider.notifier).clearAllDocuments();

      final repository = ref.read(repositoryProvider);

      final stateUserProvider = ref.read(userActiveProvider);

      LoadingModal.show(context);

      final List<RolEntity> roles = await repository.getRolesWithoutToken(
          email: stateUserProvider.email!);

      final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

      rolDocumentProvider.clearAllDocuments();

      for (final rol in roles) {
        final List<DocumentEntity> documentPorElaborar =
            await repository.getDocumentPorElaborar(rol.codusuario);

        //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

        final List<DocumentEntity> documentReasignado = [];

        final allDocuments = [...documentPorElaborar, ...documentReasignado];

        rolDocumentProvider.addDocumentToRol(rol, allDocuments);
      }
    } catch (error) {
      print(error);
      throw ("$error");
    } finally {
      LoadingModal.hide(context);
    }
  }
}
