import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

// 1. Provider principal
final documentSelectedProvider = StateNotifierProvider<DocumentSelectedNotifier, DocumentsSelectedState>((ref) {
  return DocumentSelectedNotifier();
});



class DocumentSelectedNotifier extends StateNotifier<DocumentsSelectedState> {
  DocumentSelectedNotifier() : super(const DocumentsSelectedState());

  void toggleDocumentSelection(RolEntity rol, DocumentEntity document) {
    final currentDocs = Map<RolEntity, Set<DocumentEntity>>.from(state.documentsSelected);

    if (!currentDocs.containsKey(rol)) {
      currentDocs[rol] = {document};
    } else {
      final documents = Set<DocumentEntity>.from(currentDocs[rol]!);
      if (documents.contains(document)) {
        documents.remove(document);
      } else {
        documents.add(document);
      }

      if (documents.isEmpty) {
        currentDocs.remove(rol);
      } else {
        currentDocs[rol] = documents;
      }
    }

    state = state.copyWith(documentsSelected: currentDocs);
  }

  // Verificación de estado
  bool isDocumentSelected(RolEntity rol, DocumentEntity document) {
    return state.documentsSelected[rol]?.contains(document) ?? false;
  }

  // Operaciones por rol
  void clearRol(RolEntity rol) {
    if (!state.documentsSelected.containsKey(rol)) return;

    final currentDocs = Map<RolEntity, Set<DocumentEntity>>.from(state.documentsSelected);
    currentDocs.remove(rol);
    state = state.copyWith(documentsSelected: currentDocs);
  }

  // Obtener documentos
  Set<DocumentEntity> getDocumentsForRol(RolEntity rol) {
    return state.documentsSelected[rol]?.toSet() ?? {};
  }

  List<DocumentEntity> getAllDocuments() {
    return state.documentsSelected.values
        .expand((docs) => docs)
        .toList();
  }

  // Operaciones globales
  void clearAllDocuments() {
    state = const DocumentsSelectedState();
  }


  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }


  void updateCertificate(CertificateEntity certificate) {
    state = state.copyWith(certificate: certificate);
  }

  // Métricas y estadísticas
  Map<String, int> getSelectionMetrics() {
    return {
      'totalRoles': state.documentsSelected.length,
      'totalDocuments': state.totalDocuments,
    };
  }
}



class DocumentsSelectedState {
  final Map<RolEntity, Set<DocumentEntity>> documentsSelected;
  final String? password;
  final CertificateEntity? certificate;


  const DocumentsSelectedState({
    this.documentsSelected = const {},
    this.password,
    this.certificate
  });

  int get totalDocuments => documentsSelected.values
      .fold(0, (sum, docs) => sum + docs.length);


  bool hasDocumentsForRol(RolEntity rol) =>
      documentsSelected.containsKey(rol) &&
          documentsSelected[rol]!.isNotEmpty;


  int getDocumentCountForRol(RolEntity rol) =>
      documentsSelected[rol]?.length ?? 0;


  DocumentsSelectedState copyWith({
    Map<RolEntity, Set<DocumentEntity>>? documentsSelected,
    String? password,
    CertificateEntity? certificate,
  }) {
    return DocumentsSelectedState(
      documentsSelected: documentsSelected ?? this.documentsSelected,
      password: password ?? this.password,
      certificate: certificate ?? this.certificate,
    );
  }
}