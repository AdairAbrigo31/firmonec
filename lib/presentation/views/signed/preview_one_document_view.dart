import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PreviewOneDocumentView extends ConsumerStatefulWidget {
  const PreviewOneDocumentView({super.key});

  @override
  ConsumerState<PreviewOneDocumentView> createState() =>
      PreviewOneDocumentViewState();
}

class PreviewOneDocumentViewState extends ConsumerState<PreviewOneDocumentView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> testPdfAccess() async {
    final dio = Dio();

    try {
      print('Intentando acceder al PDF...');
      final response = await dio.get(
        'http://sgdtest.espol.edu.ec/bodega/tmp/20150000690000016800.pdf',
        options: Options(
          followRedirects: true,
          validateStatus: (status) =>
              true, // Para ver cualquier código de estado
          responseType: ResponseType.bytes,
        ),
      );

      print('Status code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Content Type: ${response.headers.value('content-type')}');
      print('Content Length: ${response.data?.length ?? 'N/A'} bytes');
    } catch (e) {
      if (e is DioException) {
        print('Dio Error type: ${e.type}');
        if (e.response != null) {
          print('Response data: ${e.response?.data}');
        }
      } else {
        print('Error no relacionado con Dio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final oneDocumentSelectedState = ref.read(oneDocumentSelectedPreviewProvider).currentDocument;
    final pdfUrl = oneDocumentSelectedState?.rutaDocumento;

    return SafeArea(
      child: Column(
        children: [
          // Título
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Documento con asunto: ${oneDocumentSelectedState!.asunto}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 4,
            ),
          ),
          
          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Área del PDF o mensaje de error
                Expanded(
                  child: pdfUrl != null
                      ? SfPdfViewer.network(
                          pdfUrl,
                          // Opcional: mostrar indicador de carga mientras se descarga el PDF
                          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                            // Manejar error de carga si es necesario
                          },
                        )
                      : const Center(
                          child: Text("El documento seleccionado no tiene ruta de documento"),
                        ),
                ),
                
                // Botón siempre visible en la parte inferior
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PrimaryButton(
                    text: "Firmar",
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
