
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

              const SizedBox(height: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'De: ${doc.de}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Para: ${doc.para}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Tipo: ${doc.tipoDocumento}',
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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

                  const SizedBox(height: 4),

                  Text(
                    'Tipo: ${doc.tipoDocumento}',
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

          child: roles.isEmpty 
            ? 
            const Center(child: Text("No hay roles para este usuario"))
            : 
            
            Accordion(
                
                paddingBetweenClosedSections: 10,
                contentHorizontalPadding: 0,
                headerPadding: const EdgeInsets.symmetric(horizontal: 0),
                //paddingListHorizontal: 0,
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16  // Aumentado de 4 a 16
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[700]!, Colors.blue[500]!],
                          
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              rol.cargo,
                              style: const TextStyle(
                                color: Colors.white,
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
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${documents.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    content: ClipRRect( // También aquí para el contenido
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                          maxWidth: double.infinity
                        ),
                        child: documents.isEmpty
                          ? const Center(child: Text("No tiene documentos para este cargo"))
                          : SingleChildScrollView(
                              clipBehavior: Clip.none, // Evita que el scroll se vea fuera
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: documents.map((document) => 
                                  buildDocumentCard(rol, document)
                                ).toList(),
                              ),
                            ),
                      ),
                    ),
                  );
                }).toList(),
              ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            text: "Firmar",
            onPressed: () => router.pushNamed("preview_all_documents_selected"),
          ),
        ),
      ],
    );
  }


  

}