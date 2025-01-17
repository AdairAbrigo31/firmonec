import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

import '../../configuration/microsoftID.dart';

class GetInformationUserController {
  static Future<void> executeActionsWithMicrosoft(WidgetRef ref) async {

    final repository = ref.read(repositoryProvider);

    final valid = await repository.loginWithMicrosoft();

    print("Paso el login de microsoft exito");

    final responseData = await repository.getTokenBackend(valid.token!);

    print("Paso el token del backend");

    if (responseData != null) {

      print("response token : $responseData");

      final userNotifier = ref.read(userActiveProvider.notifier);

      userNotifier.updateUser(email: responseData["email"], token: responseData["token"]);

      final stateUserProvider = ref.read(userActiveProvider);

      print("Peticion de roles");

      final List<RolEntity> roles = await repository.getRoles(email: stateUserProvider.email!, token: stateUserProvider.token!);

      print("Peticion de roles terminada");

      final rolDocProvider = ref.read(rolDocumentsProvider.notifier);

      rolDocProvider.clearAllDocuments();

      for (final rol in roles) {

        final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);

        //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

        final List<DocumentEntity> documentReasignado = [];

        final allDocuments = [...documentPorElaborar, ...documentReasignado];

        rolDocProvider.addDocumentToRol(rol, allDocuments);

      }

      print("Su usuario es : ${stateUserProvider.email}, y token: ${stateUserProvider.token} y sus roles son: $roles");
    }

  }


  static Future<void> executeActionsWithouToken(
      {required WidgetRef ref}) async {
    final userProvider = ref.read(userActiveProvider);
    print(ref.watch(userActiveProvider).email);
    final repository = ref.read(repositoryProvider);
    final List<RolEntity> roles =
        await repository.getRolesWithoutToken(email: userProvider.email!);
    final rolDocProvider = ref.read(rolDocumentsProvider.notifier);
    rolDocProvider.clearAllDocuments();
    for (final rol in roles) {
      final List<DocumentEntity> documentPorElaborar =
          await repository.getDocumentPorElaborar(rol.codusuario);
      //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);
      final List<DocumentEntity> documentReasignado = [];
      final allDocuments = [...documentPorElaborar, ...documentReasignado];
      rolDocProvider.addDocumentToRol(rol, allDocuments);
    }
  }
}
