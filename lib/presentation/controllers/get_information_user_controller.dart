import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';


class GetInformationUserController {


  static Future<Map<String, dynamic>?> _executeCompleteLogin (WidgetRef ref) async {

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



  static Future<void> getDataQuipux(WidgetRef ref) async {

    try {

      final repository = ref.read(repositoryProvider);

      final responseData = await _executeCompleteLogin(ref);

      if (responseData != null) {

        final userNotifier = ref.read(userActiveProvider.notifier);

        userNotifier.updateUser(email: responseData["email"], token: responseData["token"]);

        final stateUserProvider = ref.read(userActiveProvider);

        final List<RolEntity> roles = await repository.getRoles(email: stateUserProvider.email!, token: stateUserProvider.token!);

        print("Peticion de roles terminada");

        final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

        rolDocumentProvider.clearAllDocuments();

        for (final rol in roles) {

          final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);

          //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

          final List<DocumentEntity> documentReasignado = [];

          final allDocuments = [...documentPorElaborar, ...documentReasignado];

          rolDocumentProvider.addDocumentToRol(rol, allDocuments);

        }

      }

    } catch (error) {

      throw ("$error");

    }
  }




  static Future<void> executeActionsWithouToken({required WidgetRef ref}) async {

    final userProvider = ref.read(userActiveProvider);

    final repository = ref.read(repositoryProvider);

    final List<RolEntity> roles = await repository.getRolesWithoutToken(email: userProvider.email!);

    final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

    rolDocumentProvider.clearAllDocuments();
    for (final rol in roles) {

      final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);

      //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

      final List<DocumentEntity> documentReasignado = [];

      final allDocuments = [...documentPorElaborar, ...documentReasignado];

      rolDocumentProvider.addDocumentToRol(rol, allDocuments);
    }
  }




  static Future<void> refreshDataQuipux (WidgetRef ref) async {

    final repository = ref.read(repositoryProvider);

    final stateUserProvider = ref.read(userActiveProvider);

    final List<RolEntity> roles = await repository.getRoles(email: stateUserProvider.email!, token: stateUserProvider.token!);

      final rolDocumentProvider = ref.read(rolDocumentsProvider.notifier);

      rolDocumentProvider.clearAllDocuments();

      for (final rol in roles) {

        final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);

        //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

        final List<DocumentEntity> documentReasignado = [];

        final allDocuments = [...documentPorElaborar, ...documentReasignado];

        rolDocumentProvider.addDocumentToRol(rol, allDocuments);

      }
  }
}
