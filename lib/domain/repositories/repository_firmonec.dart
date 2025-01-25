import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

enum AuthError { invalidCredentials, networkError, serverError, unknown }

class AuthResult {
  final bool success;
  final String? token;
  final AuthError? error;
  final String? errorMessage;

  AuthResult.success(this.token)
      : success = true,
        error = null,
        errorMessage = null;

  AuthResult.failure(this.error, [this.errorMessage])
      : success = false,
        token = null;
}

abstract class RepositoryFirmonec {
  // Agregar los parametros necesarios para las peticiones

  Future<AuthResult> login();

  Future<Map<String, dynamic>?> getTokenBackend(String tokenEntraID);

  Future<List<RolEntity>> getRoles({required String email, required String token});

  Future<List<RolEntity>> getRolesWithoutToken({required String email});

  Future<List<DocumentoPorElaborarEntity>> getDocumentReasignado(
      String codeRol);

  Future<List<DocumentoPorElaborarEntity>> getDocumentPorElaborar(
      String codeRol
  );

  Future<ResponseSignDocument> signDocument(
    {
      required String idDocument, 
      required int codeUser, 
      required String base64Certificate, 
      required String keyCertificate
    }
  );

}
