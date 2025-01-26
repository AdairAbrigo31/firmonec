
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';


final oneDocumentSelectedPreviewProvider = StateNotifierProvider<OneDocumentSelectedPreviewNotifier, OneDocumentSelectedPreviewState>((ref) {
  return OneDocumentSelectedPreviewNotifier();
});



class OneDocumentSelectedPreviewNotifier extends StateNotifier<OneDocumentSelectedPreviewState> {
  OneDocumentSelectedPreviewNotifier() : super(OneDocumentSelectedPreviewState());

  void setDocument(DocumentEntity document) {
    state = state.copyWith(
      currentDocument: document,
    );
  }

  void setRol(RolEntity rol) {
    state = state.copyWith(
      rol: rol
    );
  }

  void clearDocument() {
    state = OneDocumentSelectedPreviewState();
  }

}



class OneDocumentSelectedPreviewState {
  final RolEntity? rol;
  final DocumentEntity? currentDocument;

  OneDocumentSelectedPreviewState({
    this.currentDocument,
    this.rol
  });

  OneDocumentSelectedPreviewState copyWith({
    DocumentEntity? currentDocument,
    RolEntity? rol,

  }) {
    return OneDocumentSelectedPreviewState(
      currentDocument: currentDocument ?? this.currentDocument,
      rol: rol ?? this.rol
    );
  }
}
