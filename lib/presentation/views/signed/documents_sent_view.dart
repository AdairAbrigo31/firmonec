import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class DocumentsSentView extends ConsumerStatefulWidget {
  const DocumentsSentView({super.key});

  @override
  ConsumerState<DocumentsSentView> createState() => _DocumentsSentViewState();
}

class _DocumentsSentViewState extends ConsumerState<DocumentsSentView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await GetDocumentsSentController.getDocumentSent(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final documentSentProvider = ref.watch(documentsSentProvider);
    final documents =
        documentSentProvider.documentsSentByRol?.keys.toList() ?? [];

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
                final docs = documentSentProvider.getDocumentsSentForRol(rol);

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
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(doc.id),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // Navigate to document details
                                },
                              ),
                            );
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
