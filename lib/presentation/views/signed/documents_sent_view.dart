import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class DocumentsSentView extends ConsumerStatefulWidget {
  const DocumentsSentView({super.key});

  @override
  ConsumerState<DocumentsSentView> createState() {
    return DocumentsSentViewState();
  }
}

class DocumentsSentViewState extends ConsumerState<DocumentsSentView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _centerSelectedTab(int index) {
    if (!_scrollController.hasClients) return;

    // Calculamos la posición aproximada de la tab
    const tabWidth = 150.0; // Ancho aproximado de cada tab
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (tabWidth * index) - (screenWidth / 2) + (tabWidth / 2);

    // Aseguramos que el offset esté dentro de los límites
    final maxOffset = _scrollController.position.maxScrollExtent;
    const minOffset = 0.0;
    final finalOffset = offset.clamp(minOffset, maxOffset);

    // Animamos el scroll a la posición calculada
    _scrollController.animateTo(
      finalOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    final documentSentProvider = ref.read(documentsSentProvider);
    final documents =
        documentSentProvider.documentsSentByRol?.keys.toList() ?? [];

    print("Documentos enviados: $documents");
    _tabController = TabController(length: documents.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final documentSentProvider = ref.read(documentsSentProvider);
    final documents =
        documentSentProvider.documentsSentByRol?.keys.toList() ?? [];

    return SafeArea(
        child: RefreshIndicator(
            child: Column(
              children: [
                if (documents.isEmpty)
                  const Expanded(
                      child:
                          Center(child: Text("No hay roles para este usuario")))
                else
                  Expanded(
                      child: Column(
                    children: [Text("Data")],
                  ))
              ],
            ),
            onRefresh: () async {
              final documentSentProvider = ref.read(documentsSentProvider);

              final updateDocumentsSent =
                  documentSentProvider.documentsSentByRol?.keys.toList() ?? [];
              if (updateDocumentsSent.length != documents.length) {
                _tabController = TabController(
                    length: updateDocumentsSent.length, vsync: this);
              }

              return Future.value();
            }));
  }
}
