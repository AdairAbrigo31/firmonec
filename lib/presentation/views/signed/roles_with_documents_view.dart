import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/controllers/controllers.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class RolesWithDocumentsView extends ConsumerStatefulWidget {
  const RolesWithDocumentsView({super.key});

  @override
  ConsumerState<RolesWithDocumentsView> createState() =>
      _RolesWithDocumentsViewState();
}

class _RolesWithDocumentsViewState extends ConsumerState<RolesWithDocumentsView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget buildDocumentCard(RolEntity rol, DocumentEntity doc) {
    if (doc is DocumentoPorElaborarEntity) {
      return CardDocumentPorElaborar(doc: doc, rol: rol);
    } else if (doc is DocumentReasignadoEntity) {
      return CardDocumentReasignado(rol, doc);
    }

    return Card(
      child: ListTile(
        title: Text(doc.asunto),
        subtitle: Text(doc.tipoDocumento),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await GetInformationUserController.refreshDataQuipuxWithoutToken(
        ref, context);
  }

  @override
  Widget build(BuildContext context) {
    final rolDocProvider = ref.watch(rolDocumentsProvider);
    final roles = rolDocProvider.documentsByRol?.keys.toList() ?? [];

    // Manage TabController lifecycle based on roles length
    if (roles.length != (_tabController?.length ?? 0)) {
      _tabController?.dispose();
      _tabController = roles.isNotEmpty
          ? TabController(length: roles.length, vsync: this)
          : null;
    }

    if (roles.isEmpty) {
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
            tabs: roles
                .map((rol) => Tab(
                      child: Row(
                        children: [
                          Text(
                            rol.cargo,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "( ${rolDocProvider.getDocumentsForRol(rol).length} )",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController!,
              children: roles.map((rol) {
                final documents = rolDocProvider.getDocumentsForRol(rol);
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: documents.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(
                              height: 300,
                              child: Center(
                                child:
                                    Text("No tiene documentos para este cargo"),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final doc = documents[index];
                            return buildDocumentCard(rol, doc);
                          },
                        ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              text:
                  "Firmar ( ${ref.watch(documentSelectedProvider).totalDocuments} )",
              onPressed: () {
                final stateDocumentsSelected =
                    ref.read(documentSelectedProvider.notifier);

                if (stateDocumentsSelected.isEmpty()) {
                  var snackBar = const SnackBar(
                      content: Text('Debes seleccionar al menos un documento'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                router.pushNamed("preview_all_documents_selected");
              },
            ),
          ),
        ],
      ),
    );
  }
}
