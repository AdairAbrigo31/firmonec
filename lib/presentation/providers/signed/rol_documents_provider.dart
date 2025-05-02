import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

final rolDocumentsProvider =
    StateNotifierProvider<RolDocumentNotifier, RolDocumentsState>((ref) {
  return RolDocumentNotifier(
    RolDocumentsState(documentsByRol: {}, isLoading: false, errorMessage: null),
  );
});

class RolDocumentNotifier extends StateNotifier<RolDocumentsState> {
  RolDocumentNotifier(super.state);

  void addDocumentToRol(RolEntity rol, List<DocumentEntity> newDocuments) {
    final currentDocs =
        Map<RolEntity, List<DocumentEntity>>.from(state.documentsByRol ?? {});
    if (currentDocs.containsKey(rol)) {
      currentDocs[rol] = [...currentDocs[rol]!, ...newDocuments];
    } else {
      currentDocs[rol] = newDocuments;
    }
    state = state.copyWith(documentsByRol: currentDocs);
  }

  void clearDocumentsForRol(RolEntity rol) {
    final currentDocs =
        Map<RolEntity, List<DocumentEntity>>.from(state.documentsByRol ?? {});
    currentDocs.remove(rol);
    state = state.copyWith(documentsByRol: currentDocs);
  }

  void clearAllDocuments() {
    state = state.copyWith(documentsByRol: {});
  }
}

// Estado
class RolDocumentsState {
  final Map<RolEntity, List<DocumentEntity>>? documentsByRol;
  final bool isLoading;
  final String? errorMessage;

  RolDocumentsState(
      {this.documentsByRol,
      required this.isLoading,
      required this.errorMessage});

  RolDocumentsState copyWith({
    Map<RolEntity, List<DocumentEntity>>? documentsByRol,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RolDocumentsState(
      documentsByRol: documentsByRol ?? this.documentsByRol,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<DocumentEntity> getDocumentsForRol(RolEntity rol) {
    return documentsByRol?[rol] ?? [];
  }
}
