import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/buttons/buttons.dart';

class PreviewDocumentView extends ConsumerStatefulWidget {
  const PreviewDocumentView({super.key});

  @override
  ConsumerState<PreviewDocumentView> createState() =>
      PreviewDocumentViewState();
}

class PreviewDocumentViewState extends ConsumerState<PreviewDocumentView> {
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

    /*testPdfAccess();
    print("Cargando PDF desde: $pdfUrl");*/


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
            child: pdfUrl == null ?
            Column(
              children: [
                SfPdfViewer.network(pdfUrl!),
                PrimaryButton(text: "Firmar", onPressed: (){

                })

              ],
            )
                :
            Text("El documento seleccionado no tiene ruta de documento")
          ),

        ],
      ),

    );
  }
}
