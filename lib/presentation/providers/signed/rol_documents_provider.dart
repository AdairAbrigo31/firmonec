/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';

// Provider
final rolDocumentProvider = StateNotifierProvider<RolDocumentNotifier, RolDocumentsState>((ref) {
  final repository = ref.watch(repositoryProvider); // Asumiendo que tienes un provider para el repository
  return RolDocumentNotifier(
      RolDocumentsState(
          documentsByRol: {},
          isLoading: false,
          errorMessage: null
      ),
      repository
  );
});


// Notifier
class RolDocumentNotifier extends StateNotifier<RolDocumentsState> {
  final RepositoryFirmonec repository;

  RolDocumentNotifier(super.state, this.repository);

  // Cargar documentos para un rol específico
  Future<void> loadDocumentsForRol(String rolId) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final documents = await repository.getDocumentsByRol();
      final currentDocs = Map<String, List<DocumentEntity>>.from(state.documentsByRol ?? {});
      currentDocs[rolId] = documents;

      state = state.copyWith(
          documentsByRol: currentDocs,
          isLoading: false
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          errorMessage: e.toString()
      );
    }
  }

  // Cargar documentos para múltiples roles
  Future<void> loadDocumentsForRoles(List<String> rolIds) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      for (final rolId in rolIds) {
        await loadDocumentsForRol(rolId);
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          errorMessage: e.toString()
      );
    }
  }

  // Limpiar documentos de un rol específico
  void clearDocumentsForRol(String rolId) {
    final currentDocs = Map<String, List<DocumentEntity>>.from(state.documentsByRol ?? {});
    currentDocs.remove(rolId);
    state = state.copyWith(documentsByRol: currentDocs);
  }

  // Limpiar todos los documentos
  void clearAllDocuments() {
    state = state.copyWith(documentsByRol: {});
  }
}

// Estado
class RolDocumentsState {
  final Map<String, List<DocumentEntity>>? documentsByRol;
  final bool isLoading;
  final String? errorMessage;

  RolDocumentsState({
    this.documentsByRol,
    required this.isLoading,
    required this.errorMessage
  });

  RolDocumentsState copyWith({
    Map<String, List<DocumentEntity>>? documentsByRol,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RolDocumentsState(
      documentsByRol: documentsByRol ?? this.documentsByRol,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Método de utilidad para obtener documentos de un rol específico
  List<DocumentEntity> getDocumentsForRol(String rolId) {
    return documentsByRol?[rolId] ?? [];
  }
}*/
