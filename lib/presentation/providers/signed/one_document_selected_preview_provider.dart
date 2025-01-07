
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';


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

  void clearDocument() {
    state = OneDocumentSelectedPreviewState();
  }

}



class OneDocumentSelectedPreviewState {
  final DocumentEntity? currentDocument;

  OneDocumentSelectedPreviewState({
    this.currentDocument,
  });

  OneDocumentSelectedPreviewState copyWith({
    DocumentEntity? currentDocument,

  }) {
    return OneDocumentSelectedPreviewState(
      currentDocument: currentDocument ?? this.currentDocument,
    );
  }
}
