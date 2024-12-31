
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';

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


  Future<AuthResult> loginWithMicrosoft();


  Future<UserEntity> getInfoUserAfterLogin(String tokenAccess);


  Future<String> getNumberId(String email);


  Future<List<RolEntity>> getRoles( { required String email, required String token});


  Future<List<DocumentoPorElaborarEntity>> getDocumentReasignado(String codeRol);


  Future<List<DocumentoPorElaborarEntity>> getDocumentPorElaborar(String codeRol);


  Future<void> signAllDocumentsByRol();


  Future<void> signAtLeastOneDocumentByRol();

}