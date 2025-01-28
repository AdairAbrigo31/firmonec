import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class PreviewOneDocumentView extends ConsumerStatefulWidget {
  const PreviewOneDocumentView({super.key});

  @override
  ConsumerState<PreviewOneDocumentView> createState() =>
      PreviewOneDocumentViewState();
}

class PreviewOneDocumentViewState extends ConsumerState<PreviewOneDocumentView> { 
  
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final oneDocumentSelectedState = ref.read(oneDocumentSelectedPreviewProvider);
    final pdfUrl = oneDocumentSelectedState.currentDocument?.rutaDocumento;

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
                  "Rol: ${oneDocumentSelectedState.rol!.cargo}",
                  style: AppTypography.bodyMedium,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Asunto: ${oneDocumentSelectedState.currentDocument!.asunto}",
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
                // Área del PDF o mensaje de error
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: pdfUrl != null ? 
                    
                    SfPdfViewer.network(
                      pdfUrl,
                      // Opcional: mostrar indicador de carga mientras se descarga el PDF
                      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                        // Manejar error de carga si es necesario
                      },
                    )
                    : 
                    const Center(
                      child: Text("El documento seleccionado no tiene ruta de documento"),
                    ),
                  )
                  
                  
                  
                ),

                
                Padding(

                  padding: const EdgeInsets.all(4.0),
                  child: PrimaryButton(

                    text: "Firmar documento",
                    onPressed: () {

                      router.pushNamed("certificates_for_sign");

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
