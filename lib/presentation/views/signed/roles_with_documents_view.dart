import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/app_typography.dart';

class RolesWithDocumentsView extends ConsumerStatefulWidget {
  const RolesWithDocumentsView({super.key});

  @override
  ConsumerState<RolesWithDocumentsView> createState() => RolesWithDocumentsQuipuxViewState();
}

class RolesWithDocumentsQuipuxViewState extends ConsumerState<RolesWithDocumentsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Widget buildDocumentCard(RolEntity rol, DocumentEntity doc) {
    final oneDocumentSelectedPreviewNotifier = ref.read(oneDocumentSelectedPreviewProvider.notifier);

    if (doc is DocumentoPorElaborarEntity) {

      final fecha = DateTime.parse(doc.fechaDocumento);

      final fechaFormateada = "${fecha.day}/${fecha.month}/${fecha.year}";

      return Card(

        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),

        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con badge de tipo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    children: [
                      Text(
                        'Fecha: $fechaFormateada',
                        textAlign: TextAlign.start,
                        style: AppTypography.bodyMedium
                      ),

                      const SizedBox(height: 5,),

                      Text(
                        'Categoria: ${doc.categoria}',
                        textAlign: TextAlign.start,
                        style: AppTypography.bodyMedium,
                      ),

                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Text(
                      'Por Elaborar',
                      style: AppTypography.bodyMedium
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 12),

              // Asunto con manejo de overflow
              Text(
                "Asunto: ${doc.asunto}",
                style: AppTypography.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),

              const SizedBox(height: 4),

              Text(
                'Para: ${doc.para}',
                style: AppTypography.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),  

              const SizedBox(height: 4),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  if (doc.rutaDocumento != null)
                  TextButton.icon(
                    label: Text(
                      'Ver PDF',
                      style: AppTypography.bodySmall,
                      
                    ),
                    onPressed: () {

                      oneDocumentSelectedPreviewNotifier.setDocument(doc);
                      oneDocumentSelectedPreviewNotifier.setRol(rol);
                      router.pushNamed("preview_one_document");

                    },
                  )
                  else 
                  Text(
                    "No hay PDF",
                    style: AppTypography.bodySmall,
                  ),

                  const SizedBox(width: 8),

                  CheckboxDocument(rol: rol, document: doc)
                ],
              ),
            ],
          ),
        ),
      );

    } else if (doc is DocumentReasignadoEntity) {

      final fecha = DateTime.parse(doc.fechaReasignacion);

      final fechaFormateada = "${fecha.day}/${fecha.month}/${fecha.year}";

      return Card(

        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Padding(

          padding: const EdgeInsets.all(12.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fecha: $fechaFormateada',
                    style: const TextStyle(fontSize: 13),
                  ),

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Text(
                      'Reenviado',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                doc.asunto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'De: ${doc.fechaReasignacion}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Para: ${doc.reasignadoPor}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

              ),

              const SizedBox(height: 12),
              
              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  if (doc.rutaDocumento != null)
                  TextButton.icon(
                    icon: const Icon(Icons.visibility),
                    label: const Text('Ver PDF'),
                    onPressed: () {

                      oneDocumentSelectedPreviewNotifier.setDocument(doc);
                      router.pushNamed('preview_one_document');
                      
                    },
                  )

                  else 
                  const Text("No hay PDF"),

                  const SizedBox(width: 8),
                  
                  CheckboxDocument(rol: rol, document: doc)
                ],
              ),
            ],
          ),
        ),
      );
    }


    return Card(
      child: ListTile(
        title: Text(doc.asunto),
        subtitle: Text(doc.tipoDocumento),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {

    final userProvider = ref.watch(userActiveProvider);

    final rolDocProvider = ref.read(rolDocumentsProvider);

    final roles = rolDocProvider.documentsByRol?.keys.toList() ?? [];

    _tabController = TabController(length: roles.length, vsync: this);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Bienvenido ${userProvider.email}", textAlign: TextAlign.center,),
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
            text: "Firmar todos",
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