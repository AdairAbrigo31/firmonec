import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';

class PreviewDocumentView extends ConsumerStatefulWidget {
  const PreviewDocumentView({super.key});

  @override
  ConsumerState<PreviewDocumentView> createState() =>
      _PreviewDocumentViewState();
}

class _PreviewDocumentViewState extends ConsumerState<PreviewDocumentView> {
  @override
  Widget build(BuildContext context) {
    final documentsSelectedState = ref.watch(documentSelectedProvider);
    final size = MediaQuery.of(context).size;

    // Aplanar la lista de documentos para más fácil manejo
    final allDocuments = documentsSelectedState.documentsSelected.entries
        .expand((entry) => entry.value.map((doc) => MapEntry(entry.key, doc)))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Documentos seleccionados para firmar (${allDocuments.length})",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allDocuments.length,
                  itemBuilder: (_, index) {
                    final rolDoc = allDocuments[index];
                    final rol = rolDoc.key;
                    final doc = rolDoc.value;

                    return SfPdfViewer.network(doc.rutaDocumento!);
                  })),
        ],
      ),
    );
  }
}
