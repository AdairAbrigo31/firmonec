import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

final documentsNotSentProvider =
    StateNotifierProvider<DocumentsNotSentNotifier, DocumentsNotSentState>(
        (ref) {
  return DocumentsNotSentNotifier(
    DocumentsNotSentState(
      documentsNotSentByRol: {},
      isLoading: false,
      errorMessage: null,
    ),
  );
});

class DocumentsNotSentNotifier extends StateNotifier<DocumentsNotSentState> {
  DocumentsNotSentNotifier(super.state);

  void clearAllDocuments() {
    state = state.copyWith(documentsNotSentByRol: {});
  }
}

class DocumentsNotSentState {
  final Map<RolEntity, List<DocumentNotSent>>? documentsNotSentByRol;
  final bool isLoading;
  final String? errorMessage;
  DocumentsNotSentState({
    this.documentsNotSentByRol,
    required this.isLoading,
    required this.errorMessage,
  });
  DocumentsNotSentState copyWith({
    Map<RolEntity, List<DocumentNotSent>>? documentsNotSentByRol,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DocumentsNotSentState(
      documentsNotSentByRol:
          documentsNotSentByRol ?? this.documentsNotSentByRol,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<DocumentNotSent> getDocumentsNotSentForRol(RolEntity rol) {
    return documentsNotSentByRol?[rol] ?? [];
  }
}
