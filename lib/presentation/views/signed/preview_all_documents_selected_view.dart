import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class PreviewAllDocumentsSelectedView extends ConsumerStatefulWidget {
  const PreviewAllDocumentsSelectedView({super.key});

  @override
  ConsumerState<PreviewAllDocumentsSelectedView> createState() =>
      _PreviewDocumentViewState();
}

class _PreviewDocumentViewState extends ConsumerState<PreviewAllDocumentsSelectedView> {
  @override
  Widget build(BuildContext context) {
    final documentsSelectedState = ref.watch(documentSelectedProvider);
    final size = MediaQuery.of(context).size;
    
    // Aplanar la lista de documentos para más fácil manejo
    final allDocuments = documentsSelectedState.documentsSelected.entries
        .expand((entry) => entry.value.map((doc) => MapEntry(entry.key, doc)))
        .toList();

    return Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título con contador de documentos
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Documentos seleccionados para firmar (${allDocuments.length})",
              maxLines: 2,
            ),
          ),
          
          // Área principal de visualización
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lista horizontal de documentos
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allDocuments.length,
                    itemBuilder: (_, index) {
                      final rolDoc = allDocuments[index];
                      final rol = rolDoc.key;
                      final doc = rolDoc.value;

                      return Container(
                        width: size.width - 15, // Ancho del contenedor del PDF
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Documento del rol ${rol.cargo} con asunto: ${doc.asunto}",
                                maxLines: 4,
                              ),
                            ),
                            
                            // Visor PDF
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                child: doc.rutaDocumento != null
                                    ? SfPdfViewer.network(
                                        doc.rutaDocumento!,
                                        pageSpacing: 0,
                                        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                                          // Manejar error de carga si es necesario
                                        },
                                      )
                                    : const Center(
                                        child: Text("Documento no disponible"),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Botón de firmar fijo en la parte inferior
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PrimaryButton(
                    text: "Firmar Documentos",
                    onPressed: () {
                      // Tu lógica de firma aquí
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
