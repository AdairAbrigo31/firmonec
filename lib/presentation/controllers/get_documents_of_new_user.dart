
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/login/login.dart';
import '../providers/signed/repository_provider.dart';

class GetDocumentsOfNewUserController {

  static void execute(Ref ref) async {

    final repository = ref.watch(repositoryProvider);
    final userActive = ref.watch(userActiveProvider);
    final formAuth = ref.watch(loginQuipuxFormProvider);

    await repository.getNumberId(userActive.email!);

    await repository.getRoles(userActive.id!, formAuth.type.toString());

    // Solicitar los roles asociados a esa cuenta de quipux
    // POnerlos en el estado que contenga los roles

    // Solicitar los documentos Por elaborar y Reasignados asociados a cada rol
    // Poner los documentos en el estado que contenga los documentos
  }

}