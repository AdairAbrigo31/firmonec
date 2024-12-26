
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class SecureStorageService {
  final storage = const FlutterSecureStorage();
  final String _credentialsKey = 'quipux_credentials';

  // Guardar nuevas credenciales
  Future<void> saveCredentials(CredentialQuipux credentials) async {
    try {
      // Obtener credenciales existentes
      List<CredentialQuipux> existingCredentials = await getAllCredentials();

      // Verificar si ya existe una entrada para este usuario y tipo
      int existingIndex = existingCredentials.indexWhere(
              (cred) => cred.email == credentials.email && cred.type == credentials.type
      );

      if (existingIndex != -1) {
        // Actualizar credenciales existentes
        existingCredentials[existingIndex] = credentials;
      } else {
        // Agregar nuevas credenciales
        existingCredentials.add(credentials);
      }

      // Convertir a JSON y guardar
      List<Map<String, dynamic>> jsonList = existingCredentials
          .map((cred) => cred.toJson())
          .toList();

      await storage.write(
        key: _credentialsKey,
        value: jsonEncode(jsonList),
      );
    } catch (e) {
      throw Exception('Error al guardar credenciales: $e');
    }
  }

  // Obtener todas las credenciales guardadas
  Future<List<CredentialQuipux>> getAllCredentials() async {
    try {
      String? jsonString = await storage.read(key: _credentialsKey);
      if (jsonString == null) return [];

      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => CredentialQuipux.fromJson(json))
          .toList()
        ..sort((a, b) => b.lastAccessed.compareTo(a.lastAccessed)); // Ordenar por último acceso
    } catch (e) {
      throw Exception('Error al obtener credenciales: $e');
    }
  }

  // Eliminar credenciales específicas
  Future<void> deleteCredentials(String email, int type) async {
    try {
      List<CredentialQuipux> credentials = await getAllCredentials();
      credentials.removeWhere(
              (cred) => cred.email == email && cred.type == type
      );

      List<Map<String, dynamic>> jsonList = credentials
          .map((cred) => cred.toJson())
          .toList();

      await storage.write(
        key: _credentialsKey,
        value: jsonEncode(jsonList),
      );
    } catch (e) {
      throw Exception('Error al eliminar credenciales: $e');
    }
  }

  // Eliminar todas las credenciales
  Future<void> deleteAllCredentials() async {
    try {
      await storage.delete(key: _credentialsKey);
    } catch (e) {
      throw Exception('Error al eliminar todas las credenciales: $e');
    }
  }
}