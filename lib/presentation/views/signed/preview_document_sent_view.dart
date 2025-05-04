import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/presentation/providers/signed/document_sent_preview_provider.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class PreviewDocumentSentView extends ConsumerStatefulWidget {
  const PreviewDocumentSentView({super.key});

  @override
  ConsumerState<PreviewDocumentSentView> createState() =>
      _PreviewOneDocumentViewState();
}

class _PreviewOneDocumentViewState
    extends ConsumerState<PreviewDocumentSentView> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final documentSentState = ref.read(documentSentPreviewProvider);
    final pdfUrl = documentSentState.currentDocument?.rutaDocumento;

    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rol: ${documentSentState.rol!.cargo}",
                  style: AppTypography.bodyMedium,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Asunto: ${documentSentState.currentDocument!.asunto}",
                  style: AppTypography.bodyMedium,
                  maxLines: 3,
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: pdfUrl != null
                      ? SfPdfViewer.network(
                          pdfUrl,
                          // Opcional: mostrar indicador de carga mientras se descarga el PDF
                          onDocumentLoadFailed:
                              (PdfDocumentLoadFailedDetails details) {
                            // Manejar error de carga si es necesario
                          },
                        )
                      : const Center(
                          child: Text(
                              "El documento seleccionado no tiene ruta de documento"),
                        ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
