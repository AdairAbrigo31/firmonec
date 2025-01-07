/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PreviewDocumentView extends ConsumerStatefulWidget {
  const PreviewDocumentView({super.key});

  @override
  ConsumerState<PreviewDocumentView> createState() => _PreviewDocumentViewState();
}

class _PreviewDocumentViewState extends ConsumerState<PreviewDocumentView> {
  Map<String, String> pdfPaths = {};

  @override
  void initState() {
    super.initState();
    _loadPDFs();
  }

  Future<void> _loadPDFs() async {
    final tempDir = await getTemporaryDirectory();
    final selectedDocs = ref.read(documentSelectedProvider);

    for (var entry in selectedDocs.documentsSelected.entries) {
      for (var doc in entry.value) {
        if (doc.base64 != null) {
          final pdfFile = File('${tempDir.path}/${doc.id}.pdf');
          await pdfFile.writeAsBytes(base64Decode(doc.base64!));
          setState(() {
            pdfPaths[doc.id] = pdfFile.path;
          });
        }
      }
    }
  }

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

                  return Container(
                    width: size.width * 0.9,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Información del documento
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cargo: ${rol.cargo}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              if (doc is DocumentoPorElaborarEntity) ...[
                                Text('De: ${doc.de}'),
                                Text('Para: ${doc.para}'),
                                Text('Fecha: ${doc.fechaDocumento}'),
                              ],
                              if (doc is DocumentReasignadoEntity) ...[
                                Text('Reasignado por: ${doc.reasignadoPor}'),
                                Text('Fecha: ${doc.fechaReasignacion}'),
                              ],
                            ],
                          ),
                        ),
                        // Vista del PDF
                        Expanded(
                          child: pdfPaths[doc.id] == null
                              ? const Center(
                            child: CircularProgressIndicator(),
                          )
                              : PDFView(
                            filePath: pdfPaths[doc.id]!,
                            enableSwipe: true,
                            swipeHorizontal: false,
                            autoSpacing: true,
                            pageFling: false,
                            onError: (error) {
                              debugPrint('Error al cargar PDF: $error');
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

  @override
  void dispose() {
    // Limpiar archivos temporales
    for (var path in pdfPaths.values) {
      File(path).delete().catchError((_) {});
    }
    super.dispose();
  }
}*/
