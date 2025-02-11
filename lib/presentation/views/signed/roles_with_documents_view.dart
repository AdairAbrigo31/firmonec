import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/cards_for%20document.dart/card_document_por_elaborar.dart';
import 'package:tesis_firmonec/presentation/widgets/cards_for%20document.dart/card_document_reasignado.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/app_typography.dart';

class RolesWithDocumentsView extends ConsumerStatefulWidget {
  const RolesWithDocumentsView({super.key});

  @override
  ConsumerState<RolesWithDocumentsView> createState() => RolesWithDocumentsQuipuxViewState();
}

class RolesWithDocumentsQuipuxViewState extends ConsumerState<RolesWithDocumentsView> with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    
    // Obtenemos los roles iniciales
    final rolDocProvider = ref.read(rolDocumentsProvider);
    final roles = rolDocProvider.documentsByRol?.keys.toList() ?? [];
    
    // Inicializamos el TabController con la longitud inicial
    _tabController = TabController(length: roles.length, vsync: this);
  }
  

  @override
  Widget build(BuildContext context) {

    final userProvider = ref.watch(userActiveProvider);

    final rolDocProvider = ref.read(rolDocumentsProvider);

    final roles = rolDocProvider.documentsByRol?.keys.toList() ?? [];

    return Column(

      children: [
        Padding(

          padding: const EdgeInsets.all(8.0),

          child: Text(
            "Bienvenido ${userProvider.email}", 
            textAlign: TextAlign.center, 
            style: AppTypography.bodyMedium
          ),
        ),
        
        if (roles.isEmpty) 
          const Expanded(
            child: Center(child: Text("No hay roles para este usuario"))
          )
        else
          Expanded(

            child: Column(

              children: [

                TabBar(
                  controller: _tabController,

                  isScrollable: true,

                  onTap: _centerSelectedTab,

                  tabs: roles.map((rol) => Tab(

                    child: 

                    Row(
                      children: [

                        Text(
                          rol.cargo,
                          style: const TextStyle(color: Colors.black),
                        ),

                        const SizedBox(width: 5,),
                        
                        Text(
                          "( ${rolDocProvider.getDocumentsForRol(rol).length} )",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          
                        )


                      ],
                    )
                    
                    
                  )).toList(),

                ),

                Expanded(

                  child: TabBarView(

                    physics: const NeverScrollableScrollPhysics(),
                    
                    controller: _tabController,   

                    children: roles.map((rol) {

                      final documents = rolDocProvider.getDocumentsForRol(rol);
                      return documents.isEmpty
                        ? const Center(child: Text("No tiene documentos para este cargo"))
                        : ListView(
                            children: documents.map((doc) => 
                              buildDocumentCard(rol, doc)
                            ).toList(),
                          );
                    }).toList(),

                  ),
                ),

              ],
            ),
          ),

        Padding(

          padding: const EdgeInsets.all(16.0),

          child: PrimaryButton(

            text: "Firmar ( ${ref.watch(documentSelectedProvider).totalDocuments} )",

            onPressed: () {

              final stateDocumentsSelected = ref.read(documentSelectedProvider.notifier);

              if (stateDocumentsSelected.isEmpty()) {
                var snackBar = const SnackBar(
                  content: Text('Debes seleccionar al menos un documento')
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }

              router.pushNamed("preview_all_documents_selected");
            },
          ),
        ),
      ],
    );
  }
}