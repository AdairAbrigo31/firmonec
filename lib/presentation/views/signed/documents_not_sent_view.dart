import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/cards_for%20document.dart/card_document_not_sent.dart';

class DocumentsNotSentView extends ConsumerStatefulWidget {
  const DocumentsNotSentView({super.key});

  @override
  ConsumerState<DocumentsNotSentView> createState() =>
      _DocumentsNotSentViewState();
}

class _DocumentsNotSentViewState extends ConsumerState<DocumentsNotSentView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await GetDocumentsNotSentController.getDocumentsNotSent(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final documentNotSentProvider = ref.watch(documentsNotSentProvider);
    final documents =
        documentNotSentProvider.documentsNotSentByRol?.keys.toList() ?? [];

    // Manage TabController lifecycle based on documents length
    if (documents.length != (_tabController?.length ?? 0)) {
      _tabController?.dispose();
      _tabController = documents.isNotEmpty
          ? TabController(length: documents.length, vsync: this)
          : null;
    }

    if (documents.isEmpty) {
      return SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(
                height: 300,
                child: Center(child: Text("No hay roles para este usuario")),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          TabBar(
            controller: _tabController!,
            isScrollable: true,
            tabs: documents.map((rol) => Tab(text: rol.cargo)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController!,
              children: documents.map((rol) {
                final docs =
                    documentNotSentProvider.getDocumentsNotSentForRol(rol);

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: docs.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(
                              height: 300,
                              child: Center(child: Text("No hay documentos")),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final doc = docs[index];
                            return CardDocumentNotSent(doc: doc, rol: rol);
                          },
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
