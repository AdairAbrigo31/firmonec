
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class GetInformationUserController {

  static void execute(String tokenAccess, WidgetRef ref) async {
    print("EL token de acceso llego al controller : $tokenAccess");
    final repository = ref.read(repositoryProvider);
    final UserEntity user = await repository.getInfoUserAfterLogin(tokenAccess);
    final idUser = await repository.getNumberId(user.mail);
    user.copyWith(numberCI: idUser);
    //Recuperar el id

  }


}