
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class GetInformationUserController {

  static void execute(String tokenAccess, WidgetRef ref) async {
    print("EL token de acceso llego al controller : $tokenAccess");
    final repository = ref.read(repositoryProvider);
    final UserEntity user = await repository.getInfoUserAfterLogin(tokenAccess);
    final idUser = await repository.getNumberId(user.mail);
    user.copyWith(numberCI: idUser);
    final List<RolEntity> roles = await  repository.getRoles(user.numberCI!, user.typeQuipux!);
    
    final documentsProvider = ref.read(rolDocumentProvider.notifier);
    for (final rol in roles){
      final List<DocumentEntity> documentsPorElaborar = await repository.getDocumentPorElaborar(rol.codusuario);
      final List<DocumentEntity> documentsReasignado = await repository.getDocumentReasignado(rol.codusuario);
    }
    //Recuperar el id

  }


}