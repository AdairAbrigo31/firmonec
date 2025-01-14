
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

    print("Paso el login con exito");

    //Ejecutar acciones para enviar el token y recuperar el nuevo desde el backend
    final responseToken = await repository.getTokenBackend(valid.token!);

    if(responseToken != null){

      print("response token : $responseToken");
      
      /* final userNotifier = ref.read(userActiveProvider.notifier);

      userNotifier.updateUser(email: user.mail, token: valid.token);

      final stateUserProvider = ref.read(userActiveProvider);

      print("Su usuario es : ${stateUserProvider.email}, y token: ${stateUserProvider.token}"); */

    }

    final oauth = AadOAuth(MicrosoftID.config);

    oauth.logout();
  }



  static Future<void> executeActionWithVPN({ required WidgetRef ref }) async {
    final userProvider = ref.read(userActiveProvider);
    final repository = ref.read(repositoryProvider);
    print("Usuario que hara la peticion: ${userProvider.email} con token: ${userProvider.token}");
    final List<RolEntity> roles = await repository.getRoles(email: userProvider.email!, token: userProvider.token);
    print(roles);
    /*for(final rol in roles){
      final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);
      final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);
    }*/
  }


  static Future<void> executeActionsWithouToken({ required WidgetRef ref }) async {
    final userProvider = ref.read(userActiveProvider);
    print(ref.watch(userActiveProvider).email);
    final repository = ref.read(repositoryProvider);
    final List<RolEntity> roles = await repository.getRolesWithoutToken(email: userProvider.email!);
    final rolDocProvider = ref.read(rolDocumentProvider.notifier);
    rolDocProvider.clearAllDocuments();
    for(final rol in roles){
      final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);
      //final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);
      final List<DocumentEntity> documentReasignado = [];
      final allDocuments = [...documentPorElaborar, ...documentReasignado];
      rolDocProvider.addDocumentToRol(rol, allDocuments);
    }
  }




}