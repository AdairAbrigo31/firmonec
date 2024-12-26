
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

enum AuthError {
  invalidCredentials,
  networkError,
  serverError,
  unknown
}

class AuthResult {
  final bool success;
  final String? token;
  final AuthError? error;
  final String? errorMessage;

  AuthResult.success(this.token) :
        success = true,
        error = null,
        errorMessage = null;

  AuthResult.failure(this.error, [this.errorMessage]) :
        success = false,
        token = null;
}



abstract class RepositoryFirmonec {
  // Agregar los parametros necesarios para las peticiones

  //REDIRECCIONAR a la libreria de MicrosoftID
  Future<AuthResult> authUser();


  Future<AuthResult> loginWithMicrosoft();


  Future<void> getNumberId(String email);


  Future<List<RolEntity>> getRoles(String numberId, String typeUser);


  Future<List<DocumentoPorElaborarEntity>> getDocumentReasignado(String codeRol);


  Future<List<DocumentoPorElaborarEntity>> getDocumentPorElaborar(String codeRol);


  Future<void> signAllDocumentsByRol();


  Future<void> signAtLeastOneDocumentByRol();

}