
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class GetInformationUserController {

  static void execute(String tokenAccess, WidgetRef ref) async {
    print("EL token de acceso llego al controller : $tokenAccess");
    final repository = ref.read(repositoryProvider);
    final data = await repository.getInfoUserAfterLogin(tokenAccess);
    print(data);
    //Recuperar el id

  }


}