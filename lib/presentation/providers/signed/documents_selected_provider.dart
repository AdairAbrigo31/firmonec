
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';


final documentSelectedProvider = StateNotifierProvider<DocumentSelectedNotifier, DocumentsSelectedState>((ref) {
  return DocumentSelectedNotifier(
    DocumentsSelectedState(
      documentsSelected: {}
    )
  );
});


class DocumentSelectedNotifier extends StateNotifier<DocumentsSelectedState> {
  DocumentSelectedNotifier(super._state);

  void updateCheckBox(RolEntity rol, DocumentEntity document, bool check){
    if(check){
      addDocumentToRol(rol, document);
    } else {
      removeDocumentToRol(rol, document);
    }
  }

  bool isDocumentSelected(RolEntity rol, DocumentEntity document) {
    return state.documentsSelected[rol]?.contains(document) ?? false;
  }

  void removeDocumentToRol(RolEntity rol, DocumentEntity document){
    final currentDocs = Map<RolEntity, List<DocumentEntity>>.from(state.documentsSelected);
    if(currentDocs.containsKey(rol)){
      currentDocs[rol]!.remove(document);
    }
    state = state.copyWith(documentsSelected: currentDocs);
  }

  int get totalDocumentsSelected {
    return state.documentsSelected.values.fold(0, (sum, docs) => sum + docs.length);
  }


  void addDocumentToRol(RolEntity rol, DocumentEntity newDocument){
    final currentDocs = Map<RolEntity, List<DocumentEntity>>.from(state.documentsSelected ?? {});
    if(currentDocs.containsKey(rol)){
      currentDocs[rol] = [...currentDocs[rol]!, newDocument];
    } else {
      currentDocs[rol] = [newDocument];
    }
    state = state.copyWith(documentsSelected: currentDocs);
  }

  void clearDocumentForRol(RolEntity rol, DocumentEntity document){

  }

  void clearAllDocuments(){
    state = state.copyWith(documentsSelected: {});
  }

}



class DocumentsSelectedState {
  final Map<RolEntity, List<DocumentEntity>> documentsSelected;

  DocumentsSelectedState({
    required this.documentsSelected
  });

  DocumentsSelectedState copyWith({
    Map<RolEntity, List<DocumentEntity>>? documentsSelected,
  }){
    return DocumentsSelectedState(
        documentsSelected: documentsSelected ?? this.documentsSelected
    );
  }
}