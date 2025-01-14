import 'package:aad_oauth/aad_oauth.dart';
import 'package:dio/dio.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/mapers/document_mapper.dart';
import 'package:tesis_firmonec/infrastructure/mapers/rol_mapper.dart';

class RepositoryFirmonecImplementation extends RepositoryFirmonec {
  //Revisar el si funciona con la palabra localhost
  final String routeBase = 'http://10.0.2.2:5299/api';

  @override
  Future<AuthResult> loginWithMicrosoft() async {
    try {
      print("Logearse");
      final oauth = AadOAuth(MicrosoftID.config);
      await oauth.login();
      final accessToken = await oauth.getAccessToken();
      if (accessToken != null) {
        return AuthResult.success(accessToken);
      } else {
        print("Fallo");
        return AuthResult.failure(
            AuthError.invalidCredentials, "Credenciales invalidas");
      }
    } catch (e) {
      print('Error durante el login: $e');
      return AuthResult.failure(AuthError.unknown, "Algo ha salido mal");
    }
  }

  @override
  Future<List<RolEntity>> getRoles(
      {required String email, String? token}) async {
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 30 * 1000),
      receiveTimeout: const Duration(seconds: 30 * 1000),
    );
    final Dio dio = Dio(baseOptions);
    try {
      final response = await dio.get(
        '$routeBase/Usuario/Cargos',
        queryParameters: {'correo': email, 'tipoUsuario': 0},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // Si la respuesta es un mensaje de error en formato string
      if (response.data is String || response.data is Map<String, dynamic>) {
        return [];
      }

      if (response.statusCode != 200) {
        throw Exception('Error al obtener roles: ${response.statusCode}');
      }

      // Verificar si la respuesta es una lista
      if (response.data is! List) {
        return [];
      }

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<RolDto> rolesDto =
          jsonList.map((json) => RolDto.fromJson(json)).toList();

      final List<RolEntity> roles = RolMapper.fromDtoList(rolesDto);

      return roles;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw "Error de autenticación: Token inválido o expirado";
      }
      throw "Error de conexión: ${e.message}";
    } catch (e) {
      // En caso de error de parseo, devolver lista vacía
      print("Error inesperado: $e");
      return [];
    } finally {
      dio.close();
    }
  }

  @override
  Future<List<RolEntity>> getRolesWithoutToken({required String email}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '$routeBase/Usuario/Cargos',
        queryParameters: {'correo': email, 'tipoUsuario': 0},
      );

      // Si la respuesta es un mensaje de error en formato string
      if (response.data is String || response.data is Map<String, dynamic>) {
        return [];
      }

      if (response.statusCode != 200) {
        throw Exception('Error al obtener roles: ${response.statusCode}');
      }

      // Verificar si la respuesta es una lista
      if (response.data is! List) {
        return [];
      }

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<RolDto> rolesDto =
          jsonList.map((json) => RolDto.fromJson(json)).toList();

      final List<RolEntity> roles = RolMapper.fromDtoList(rolesDto);

      return roles;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw "Error de autenticación: Token inválido o expirado";
      }
      throw "Error de conexión: ${e.message}";
    } catch (e) {
      // En caso de error de parseo, devolver lista vacía
      print("Error inesperado: $e");
      return [];
    } finally {
      dio.close();
    }
  }

  @override
  Future<Map<String, dynamic>?> getTokenBackend(String tokenEntraID) async {
    final dio = Dio();
    try {
      final response = await dio.post('$routeBase/Auth/Login', data: {
        'accessToken': tokenEntraID,
      });

      if (response.statusCode != 200) {
        throw Exception('Error al obtener token: ${response.statusCode}');
      }

      return response.data;
    } on DioException catch (e) {
      throw ("Error de conexión: ${e.message}");
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
        '$routeBase/DocumentoPendiente/Pendientes',
        queryParameters: {
          'idUsuario': codeRol,
        },
/*          options: Options(
              headers: {
                "Authorization": "Bearer =================>  TOKEN",
              }
          )*/
      );

      if (response.statusCode != 200) {
        throw Exception('Error al obtener roles: ${response.statusCode}');
      }

      print(response.data);

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<DocumentPorElaborarDto> dtos = jsonList
          .map((json) => DocumentPorElaborarDto.fromJson(json))
          .toList();

      final List<DocumentoPorElaborarEntity> documentsPorElaborar =
          DocumentMapper.fromDtoList(dtos);

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
}
