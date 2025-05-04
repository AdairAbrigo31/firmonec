import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

final documentSentPreviewProvider = StateNotifierProvider<
    DocumentSentPreviewNotifier, DocumentSentPreviewState>((ref) {
  return DocumentSentPreviewNotifier();
});

class DocumentSentPreviewNotifier
    extends StateNotifier<DocumentSentPreviewState> {
  DocumentSentPreviewNotifier() : super(DocumentSentPreviewState());

  void setDocument(DocumentSent document) {
    state = state.copyWith(
      currentDocument: document,
    );
  }

  void setRol(RolEntity rol) {
    state = state.copyWith(rol: rol);
  }

  void clearDocument() {
    state = DocumentSentPreviewState();
  }
}

class DocumentSentPreviewState {
  final RolEntity? rol;
  final DocumentSent? currentDocument;

  DocumentSentPreviewState({this.currentDocument, this.rol});

  DocumentSentPreviewState copyWith({
    DocumentSent? currentDocument,
    RolEntity? rol,
  }) {
    return DocumentSentPreviewState(
        currentDocument: currentDocument ?? this.currentDocument,
        rol: rol ?? this.rol);
  }
}
