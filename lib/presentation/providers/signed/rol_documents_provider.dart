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

  void updateDocumentsByRol(Map<String, List<DocumentEntity>> documentsByRol){
    state = state.copyWith(documentsByRol: documentsByRol);
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
}
