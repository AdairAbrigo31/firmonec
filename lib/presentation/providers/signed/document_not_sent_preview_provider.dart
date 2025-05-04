import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

final documentNotSentPreviewProvider = StateNotifierProvider<
    DocumentNotSentPreviewNotifier, DocumentNotSentPreviewState>((ref) {
  return DocumentNotSentPreviewNotifier();
});

class DocumentNotSentPreviewNotifier
    extends StateNotifier<DocumentNotSentPreviewState> {
  DocumentNotSentPreviewNotifier() : super(DocumentNotSentPreviewState());

  void setDocument(DocumentNotSent document) {
    state = state.copyWith(
      currentDocument: document,
    );
  }

  void setRol(RolEntity rol) {
    state = state.copyWith(rol: rol);
  }

  void clearDocument() {
    state = DocumentNotSentPreviewState();
  }
}

class DocumentNotSentPreviewState {
  final RolEntity? rol;
  final DocumentNotSent? currentDocument;

  DocumentNotSentPreviewState({this.currentDocument, this.rol});

  DocumentNotSentPreviewState copyWith({
    DocumentNotSent? currentDocument,
    RolEntity? rol,
  }) {
    return DocumentNotSentPreviewState(
        currentDocument: currentDocument ?? this.currentDocument,
        rol: rol ?? this.rol);
  }
}
