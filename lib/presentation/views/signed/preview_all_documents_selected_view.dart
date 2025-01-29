import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis_firmonec/configuration/go_router.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/app_typography.dart';

class PreviewAllDocumentsSelectedView extends ConsumerStatefulWidget {
  const PreviewAllDocumentsSelectedView({super.key});

  @override
  ConsumerState<PreviewAllDocumentsSelectedView> createState() => _PreviewDocumentViewState();
}

class _PreviewDocumentViewState extends ConsumerState<PreviewAllDocumentsSelectedView> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final documentsSelectedState = ref.watch(documentSelectedProvider);
    
    final allDocuments = documentsSelectedState.documentsSelected.entries
        .expand((entry) => entry.value.map((doc) => MapEntry(entry.key, doc)))
        .toList();

    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          
          Expanded(
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
                        "Rol: ${allDocuments[currentPage].key.cargo}",
                        style: AppTypography.bodyMedium,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Asunto: ${allDocuments[currentPage].value.asunto}",
                        style: AppTypography.bodyMedium,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40, // Ancho del IconButton
                        child: currentPage > 0
                            ? IconButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                              )
                            : null,
                      ),

                      Expanded(
                        child: SizedBox(
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                currentPage = page;
                              });
                            },
                            itemCount: allDocuments.length,
                            itemBuilder: (_, index) {
                              final doc = allDocuments[index].value;
                              return doc.rutaDocumento != null
                                  ? SfPdfViewer.network(
                                      doc.rutaDocumento!,
                                      pageSpacing: 0,
                                      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                                        // Manejar error de carga
                                      },
                                    )
                                  : const Center(
                                      child: Text("Documento no disponible"),
                                    );
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 40, // Ancho del IconButton

                        child: currentPage < allDocuments.length - 1 ? 
                        IconButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                        )
                        : 
                        null,

                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    text: "Firmar ( ${ref.watch(documentSelectedProvider).totalDocuments} )",
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