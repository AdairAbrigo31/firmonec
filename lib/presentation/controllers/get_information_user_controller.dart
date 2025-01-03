
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';
import 'package:tesis_firmonec/infrastructure/repositories/repositories.dart';
import 'package:tesis_firmonec/presentation/providers/login/login.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class GetInformationUserController {

  static Future<void> execute({ required WidgetRef ref }) async {
    print("Ha empezado lo de mircrosfot");
    final valid = await RepositoryFirmonecImplementation().loginWithMicrosoft();
    final repository = ref.read(repositoryProvider);
    final UserEntity user = await repository.getInfoUserAfterLogin(valid.token!);
    final notifierUserProvider = ref.read(userActiveProvider.notifier);
    notifierUserProvider.updateUser(email: user.mail, token: valid.token);
    print("Ha terminado lo de microsoft");

  }

  static Future<void> executeActionsWithMicrosoft(WidgetRef ref) async {
    final valid = await RepositoryFirmonecImplementation().loginWithMicrosoft();
    if(valid.success) {
      final repository = ref.read(repositoryProvider);
      final UserEntity user = await repository.getInfoUserAfterLogin(valid.token!);
      final userProvider = ref.read(userActiveProvider.notifier);
      userProvider.updateUser(email: user.mail, token: valid.token);
    }
  }

  static Future<void> executeActionWithVPN({ required WidgetRef ref }) async {
    print("Ha terminado la peticion de roles");
    final userProvider = ref.read(userActiveProvider);
    final repository = ref.read(repositoryProvider);
    final List<RolEntity> roles = await repository.getRoles(email: userProvider.email!, token: userProvider.token);
    print(roles);
    for(final rol in roles){
      final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);
      final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);

    }
  }


  static Future<void> executeActionsWithouToken({ required WidgetRef ref }) async {
    print("Ha terminado la peticion de roles");
    final userProvider = ref.read(userActiveProvider);
    final repository = ref.read(repositoryProvider);
    final List<RolEntity> roles = await repository.getRolesWithoutToken(email: userProvider.email!);
    final rolDocProvider = ref.read(rolDocumentProvider.notifier);
    rolDocProvider.clearAllDocuments();
    print(roles);
    for(final rol in roles){
      print(rol.cargo);
      /*final List<DocumentEntity> documentPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);
      final List<DocumentEntity> documentReasignado = await repository.getDocumentReasignado(rol.codusuario);*/
      final List<DocumentEntity> documentPorElaborar = [];
      final List<DocumentEntity> documentReasignado = [];
      final allDocuments = [...documentPorElaborar, ...documentReasignado];
      rolDocProvider.addDocumentToRol(rol.cargo, allDocuments);
    }
  }




}