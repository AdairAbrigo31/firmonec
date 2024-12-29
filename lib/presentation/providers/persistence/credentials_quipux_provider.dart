

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/persistence/persistence.dart';


final credentialsQuipuxProvider = StateNotifierProvider<CredentialsQuipuxNotifier, CredentialsQuipuxState>((ref) {
  final SecureStorageService storageService = SecureStorageService();
  return CredentialsQuipuxNotifier(storageService);
});



class CredentialsQuipuxNotifier extends StateNotifier<CredentialsQuipuxState> {
  final SecureStorageService storageService;

  CredentialsQuipuxNotifier(this.storageService) : super(CredentialsQuipuxState()) {
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    try {
      final credentials = await storageService.getAllCredentials();
      state = state.copyWith(credentials: credentials);
    } catch (e) {
      state = state.copyWith(credentials: []);
    }
  }

  Future<void> saveCredential(CredentialQuipux credential) async {
    try {
      await storageService.saveCredentials(credential);
      await loadCredentials(); // Recargar la lista después de guardar
    } catch (e) {
      throw Exception('Error al guardar la credencial: $e');
    }
  }

  Future<void> deleteCredential(String username, int type) async {
    try {
      await storageService.deleteCredentials(username, type);
      await loadCredentials(); // Recargar la lista después de eliminar
    } catch (e) {
      throw Exception('Error al eliminar la credencial: $e');
    }
  }

  Future<void> deleteAllCredentials() async {
    try {
      await storageService.deleteAllCredentials();
      state = state.copyWith(credentials: []);
    } catch (e) {
      throw Exception('Error al eliminar todas las credenciales: $e');
    }
  }

  void updateCredentialSelected(CredentialQuipux credentialSelected) {
    state = state.copyWith(credentialSelected: credentialSelected);
  }
}

class CredentialsQuipuxState {
  List<CredentialQuipux> credentials;
  CredentialQuipux? credentialSelected;

  CredentialsQuipuxState({
    this.credentials = const [],
    this.credentialSelected,
  });

  CredentialsQuipuxState copyWith({
    List<CredentialQuipux>? credentials,
    CredentialQuipux? credentialSelected
  }){
    return CredentialsQuipuxState(
        credentials: credentials ?? this.credentials,
      credentialSelected: credentialSelected ?? this.credentialSelected
    );
  }
}