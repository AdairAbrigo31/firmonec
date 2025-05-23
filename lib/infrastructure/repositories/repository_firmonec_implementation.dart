import 'package:aad_oauth/aad_oauth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/mappers/mappers.dart';
import 'package:tesis_firmonec/presentation/models/models.dart';

class RepositoryFirmonecImplementation extends RepositoryFirmonec {
  final String? routeBase = dotenv.env['ROUTE_API']!;

  @override
  Future<AuthResult> login() async {
    try {
      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;

      if (!hasInternet) {
        return AuthResult.failure(
            AuthError.networkError, "Revise su conexión a internet");
      }

      final oauth = AadOAuth(MicrosoftID.config);

      await oauth.logout();

      await oauth.login();

      final accessToken = await oauth.getAccessToken();

      if (accessToken != null) {
        return AuthResult.success(accessToken);
      } else {
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
      {required String email, required String token}) async {
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 20),
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
      print("Error inesperado: $e");
      return [];
    } finally {
      dio.close();
    }
  }

  @override
  Future<List<RolEntity>> getRolesWithoutToken({required String email}) async {
    final dio = Dio(BaseOptions(
      baseUrl: routeBase!,
      connectTimeout: const Duration(seconds: 20),
    ));

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
      print("Error inesperado: $e");
      return [];
    } finally {
      dio.close();
    }
  }

  @override
  Future<Map<String, dynamic>?> getTokenBackend(String tokenEntraID) async {
    final dio = Dio(BaseOptions(
      baseUrl: routeBase!,
      connectTimeout: const Duration(seconds: 40),
    ));

    try {
      print(' Endpoint: $routeBase/Auth/Login');

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
  Future<List<DocumentoPorElaborarEntity>> getDocumentPorElaborar(
      String codeRol) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '$routeBase/DocumentoPendiente/Pendientes',
        queryParameters: {
          'idUsuario': codeRol,
        },
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

  @override
  Future<ResponseSignDocument> signDocument(
      {required String idDocument,
      required int codeUser,
      required String base64Certificate,
      required String keyCertificate}) async {
    try {
      final dio = Dio(BaseOptions(
          baseUrl: routeBase!,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20)));

      final response = await dio.post('/FirmarDocumento/Firmar', data: {
        'radicado_numero': idDocument,
        'idusuario': codeUser,
        'firma': base64Certificate,
        'key': keyCertificate
      });

      if (response.statusCode == 500) {
        final responseProcess = ResponseSignDocument(
          success: false,
          documentId: idDocument,
          error: "Algo ha salido mal",
        );

        return responseProcess;
      }
      final data = response.data[0];

      if (data['est'] == 0 || data['est'] == '0') {
        final responseProcess = ResponseSignDocument(
            success: true, documentId: idDocument, error: null);

        return responseProcess;
      }

      final responseProcess = ResponseSignDocument(
        success: false,
        documentId: idDocument,
        error: data["msg"],
      );

      return responseProcess;
    } catch (error) {
      final responseProcess = ResponseSignDocument(
        success: false,
        documentId: idDocument,
        error: "Algo ha salido mal con el documenti $idDocument",
      );

      return responseProcess;

      //throw RequestFailedException();
    }
  }

  @override
  Future<List<DocumentNotSent>> getDocumentsNotSent(String codeRol) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '$routeBase/DocumentoNoEnviado/NoEnviados',
        queryParameters: {
          'idUsuario': codeRol,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
            'Error al los documentos No enviados: ${response.statusCode}');
      }

      if (response.data == "") {
        return [];
      }

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<DocumentNotSentDto> dtos =
          jsonList.map((json) => DocumentNotSentDto.fromJson(json)).toList();

      final List<DocumentNotSent> documentsNotSent =
          DocumentNotSentMapper.fromDtoList(dtos);

      return documentsNotSent;
    } on DioException catch (e) {
      throw ("Error de conexión: ${e.message}");
    } catch (e) {
      throw Exception("Error inesperado: $e");
    } finally {
      dio.close();
    }
  }

  @override
  Future<List<DocumentSent>> getDocumentsSent(String codeRol) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        '$routeBase/DocumentoEnviado/Enviados',
        queryParameters: {
          'idUsuario': codeRol,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Error al obtener documentos enviados: ${response.statusCode}');
      }

      print(response.data);

      final List<dynamic> jsonList = response.data;
      if (jsonList.isEmpty) return [];

      final List<DocumentSentDto> dtos =
          jsonList.map((json) => DocumentSentDto.fromJson(json)).toList();

      final List<DocumentSent> documentsSent =
          DocumentSentMapper.fromDtoList(dtos);

      return documentsSent;
    } on DioException catch (e) {
      throw ("Error de conexión: ${e.message}");
    } catch (e) {
      throw Exception("Error inesperado: $e");
    } finally {
      dio.close();
    }
  }
}
