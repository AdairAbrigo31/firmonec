import 'package:aad_oauth/aad_oauth.dart';
import 'package:dio/dio.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/user_entity.dart';
import 'package:tesis_firmonec/infrastructure/mapers/document_mapper.dart';
import 'package:tesis_firmonec/infrastructure/mapers/rol_mapper.dart';

class RepositoryFirmonecImplementation extends RepositoryFirmonec {

  //Revisar el si funciona con la palabra localhost
  final String routeBase = 'http://10.0.2.2:5299/api';


  @override
  Future<AuthResult> loginWithMicrosoft() async {
    try {
      final oauth = AadOAuth(MicrosoftID.config);
      await oauth.login();
      final accessToken = await oauth.getAccessToken();

      if (accessToken != null) {
        print("acccess token: $accessToken");
        oauth.logout();
        return AuthResult.success(accessToken);
      } else {
        return AuthResult.failure(
            AuthError.invalidCredentials, "Credenciales invalidas"
        );
      }
    } catch (e) {
      print('Error durante el login: $e');
      return AuthResult.failure(
          AuthError.unknown, "Algo ha salido mal"
      );
    }
  }


  @override
  Future<String> getNumberId(String email) async {

    final dio = Dio();
    try {
      final response = await dio.get(
        '$routeBase/',
        options: Options(
            headers: {'':''})
      );
    } on DioException catch (e) {
      throw ("Error de conexión: ${e.message}");
    } catch (e) {
      throw Exception("Error inesperado: $e");
    } finally {
      dio.close();
    }

    throw UnimplementedError();
  }


  @override
  Future<List<RolEntity>> getRoles( {required String email, required String token}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '$routeBase/Usuario/Cargos',
        queryParameters: {
          'correo': email,
        },
        /*options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),*/
      );

      if (response.statusCode != 200) {
        throw Exception('Error al obtener roles: ${response.statusCode}');
      }

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<RolDto> rolesDto = jsonList.map((json) =>
          RolDto.fromJson(json)).toList();

      final List<RolEntity> roles = RolMapper.fromDtoList(rolesDto);

      return roles;
    } on DioException catch (e) {
      // Mejorado el manejo de errores
      if (e.response?.statusCode == 401) {
        throw "Error de autenticación: Token inválido o expirado";
      }
      throw "Error de conexión: ${e.message}";
    } catch (e) {
      throw Exception("Error inesperado: $e");
    } finally {
      dio.close();
    }
  }

  @override
  Future<void> signAllDocumentsByRol() {
    // TODO: implement signAllDocumentsByRol
    throw UnimplementedError();
  }


  @override
  Future<void> signAtLeastOneDocumentByRol() {
    // TODO: implement signAtLeastOneDocumentByRol
    throw UnimplementedError();
  }

  @override
  Future<List<DocumentoPorElaborarEntity>> getDocumentPorElaborar(
      String codeRol) async {
    final dio = Dio();

    try {
      final response = await dio.get(
          '$routeBase/',
          options: Options(
              headers: {
                "Authorization": "Bearer =================>  TOKEN",
              }
          )
      );

      if (response.statusCode != 200) {
        throw Exception('Error al obtener roles: ${response.statusCode}');
      }

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<DocumentDto> dtos = jsonList.map((json) =>
          DocumentDto.fromJson(json)).toList();

      final List<
          DocumentoPorElaborarEntity> documentsPorElaborar = DocumentMapper
          .fromDtoList(dtos);

      return documentsPorElaborar;
    } on DioException catch (e) {
      throw ("Error de conexión: ${e.message}");
    } catch (e) {
      throw Exception("Error inesperado: $e");
    } finally {
      dio.close();
    }
  }


  @override
  Future<List<DocumentoPorElaborarEntity>> getDocumentReasignado(
      String codeRol) {
    // TODO: implement getDocumentReasignado
    throw UnimplementedError();
  }


  @override
  Future<UserEntity> getInfoUserAfterLogin(String tokenAccess) async {
    final dio = Dio();

    try {
      const graphApiUrl = 'https://graph.microsoft.com/v1.0/me';

      final response = await dio.get(
        graphApiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $tokenAccess',
            'Accept': 'application/json',
          },
        ),
      );

      final userData = response.data; // Dio ya parsea el JSON automáticamente
      final userEntity = UserEntity.fromJson(userData);
      return (userEntity);
    } on DioException catch (e) {
      throw Exception('Failed to get user info: ${e.response?.statusCode ??
          'No status code'} - ${e.message}');
    } catch (e) {
      throw Exception('Error getting user info: $e');
    } finally {
      dio.close(); // Buena práctica cerrar el cliente
    }
  }

}