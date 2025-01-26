
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/domain/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';


class RolesDocumentsQuipuxView extends ConsumerStatefulWidget {
  const RolesDocumentsQuipuxView({super.key});

  @override
  ConsumerState<RolesDocumentsQuipuxView> createState() => RolesDocumentsQuipuxViewState();

}

class RolesDocumentsQuipuxViewState extends ConsumerState<RolesDocumentsQuipuxView>{

  int? openSectionIndex;


  Widget buildDocumentCard(RolEntity rol, DocumentEntity doc) {
    final oneDocumentSelectedPreviewNotifier = ref.read(oneDocumentSelectedPreviewProvider.notifier);

    if (doc is DocumentoPorElaborarEntity) {

      final fecha = DateTime.parse(doc.fechaDocumento);

      final fechaFormateada = "${fecha.day}/${fecha.month}/${fecha.year}";

      return Card(

        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),

        child: Padding(
          padding: const EdgeInsets.all(12.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con badge de tipo
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
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Text(
                      'Por Elaborar',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 12),

              // Asunto con manejo de overflow
              Text(
                doc.asunto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Para: ${doc.para}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Categoria: ${doc.categoria}'
                  )
                ],
              ),

              // Botones y checkbox en el footer
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
                      router.pushNamed("preview_one_document");

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Bienvenido ${userProvider.email}"),
        ),
        
        Expanded(

          child: roles.isEmpty ? 

            const Center(

              child: Text(
                "No hay roles para este usuario"
              )

            )

            : 

            SingleChildScrollView(
              
              child: Accordion(
                
                paddingBetweenClosedSections: 10,
                contentHorizontalPadding: 0,
                headerPadding: const EdgeInsets.symmetric(horizontal: 0),
                maxOpenSections: 1,
                scaleWhenAnimating: false,
                openAndCloseAnimation: false,
                headerBackgroundColor: Colors.transparent,
                headerBackgroundColorOpened: Colors.transparent,
                contentBackgroundColor: Colors.transparent,
                contentBorderColor: Colors.transparent,
                initialOpeningSequenceDelay: 0,
                children: roles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final rol = entry.value;
                  final documents = rolDocProvider.getDocumentsForRol(rol);

                  return AccordionSection(
                    
                    contentHorizontalPadding: 0,

                    headerPadding: const EdgeInsets.only(left: 22),

                    isOpen: index == openSectionIndex,

                    onOpenSection: () => setState(() => openSectionIndex = index),

                    onCloseSection: () => setState(() => openSectionIndex = null),

                    header: Container(

                      color: Theme.of(context).primaryColor,

                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16  // Aumentado de 4 a 16
                      ),


                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(

                            child: Text(
                              rol.cargo,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          
                          Container(

                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 10
                            ),

                            child: Text(
                              '${documents.length}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    content: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 300, // o el valor que necesites
                      ),

                      child: documents.isEmpty ? 
                      
                      const Center(child: Text("No tiene documentos para este cargo"))

                      : 

                      SingleChildScrollView(

                        clipBehavior: Clip.none,

                        padding: EdgeInsets.zero,

                        child: Column(

                          children: documents.map((document) => 
                            buildDocumentCard(rol, document)
                          ).toList(),
                        ),

                      ),
                    ),

                  );
                }).toList(),
              ),

            )
        ),
        
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            text: "Firmar todos",
            onPressed: () {

              final stateDocumentsSelected = ref.read(documentSelectedProvider.notifier);

              if (stateDocumentsSelected.isEmpty()) {
                var snackBar = const SnackBar(content: Text('Debes seleccionar al menos un docuento'));
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