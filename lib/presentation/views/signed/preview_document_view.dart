

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/infrastructure/entities/document_por_elaborar_entity.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewDocumentView extends ConsumerStatefulWidget {
  const PreviewDocumentView({super.key});


  @override
  ConsumerState<PreviewDocumentView> createState() => PreviewDocumentViewState();


}

class PreviewDocumentViewState extends ConsumerState<PreviewDocumentView> {
  late WebViewController controller;
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
          validateStatus: (status) => true, // Para ver cualquier código de estado
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
        print('Error message: ${e.message}');
        print('Error details: ${e.error}');
        if (e.response != null) {
          print('Response status: ${e.response?.statusCode}');
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
    final DocumentoPorElaborarEntity doc = oneDocumentSelectedState as DocumentoPorElaborarEntity;
    final pdfUrl = doc.rutaDocumento;

    testPdfAccess();
    print("Cargando PDF desde: $pdfUrl");
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Previsualización del documento seleccionado",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SfPdfViewer.network(pdfUrl),
          ),
        ],
      ),
    );
  }
}