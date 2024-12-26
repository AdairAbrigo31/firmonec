
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';

class GetCredentialsQuipuxController{

  static void execute() async {

    //Obtener todas las credenciales - metodo getAllCredentials
    final secureStorageService = SecureStorageService();
    await secureStorageService.getAllCredentials();

  }

}