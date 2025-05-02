import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

final documentsSentProvider =
    StateNotifierProvider<DocumentsSentNotifier, DocumentsSentState>((ref) {
  return DocumentsSentNotifier(
    DocumentsSentState(
      documentsSentByRol: {},
      isLoading: false,
      errorMessage: null,
    ),
  );
});

class DocumentsSentNotifier extends StateNotifier<DocumentsSentState> {
  DocumentsSentNotifier(super.state);

  void clearAllDocuments() {
    state = state.copyWith(documentsSentByRol: {});
  }
}

class DocumentsSentState {
  final Map<RolEntity, List<DocumentSent>>? documentsSentByRol;
  final bool isLoading;
  final String? errorMessage;
  DocumentsSentState({
    this.documentsSentByRol,
    required this.isLoading,
    required this.errorMessage,
  });
  DocumentsSentState copyWith({
    Map<RolEntity, List<DocumentSent>>? documentsSentByRol,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DocumentsSentState(
      documentsSentByRol: documentsSentByRol ?? this.documentsSentByRol,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<DocumentSent> getDocumentsSentForRol(RolEntity rol) {
    return documentsSentByRol?[rol] ?? [];
  }
}
