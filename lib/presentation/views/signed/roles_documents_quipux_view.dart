
import 'package:aad_oauth/aad_oauth.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/document_entity.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/login/login.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import '../../../configuration/microsoftID.dart';


class RolesDocumentsQuipuxView extends ConsumerStatefulWidget {
  const RolesDocumentsQuipuxView({super.key});

  @override
  ConsumerState<RolesDocumentsQuipuxView> createState() => RolesDocumentsQuipuxViewState();

}

class RolesDocumentsQuipuxViewState extends ConsumerState<RolesDocumentsQuipuxView>{


  Widget buildDocumentCard(DocumentEntity doc) {
    if (doc is DocumentoPorElaborarEntity) {

      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: const Icon(Icons.description),
          title: Text(
              doc.asunto,
              style: const TextStyle(fontWeight: FontWeight.bold)
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('De: ${doc.de}'),
              Text('Para: ${doc.para}'),
              Text('Fecha: ${doc.fechaDocumento}'),
              Text('Número: ${doc.numeroDocumento}'),
              Text('Fecha: ${doc.fechaDocumento}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  // Acción para ver el documento
                },
              ),
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Acción para descargar el documento
                },
              ),
            ],
          ),
        ),
      );
    } else if (doc is DocumentReasignadoEntity) { // Asumiendo que tienes esta clase
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: const Icon(Icons.description),
          title: Text(
              doc.asunto,
              style: const TextStyle(fontWeight: FontWeight.bold)
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('De: ${doc.reasignadoPor}'),
              Text('Motivo: ${doc.motivoReasignacion}'),
              Text('Fecha: ${doc.fechaReasignacion}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  // Acción para ver el documento
                },
              ),
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Acción para descargar el documento
                },
              ),
            ],
          ),
        ),
      );
    }

    // Diseño por defecto si no coincide con ningún tipo específico
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
    final rolDocProvider = ref.watch(rolDocumentProvider);
    final roles = rolDocProvider.documentsByRol?.keys.toList() ?? [];

    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("Bienvenido ${userProvider.email}"),
            roles.isEmpty
            ? Center(
              child: Text("No hay roles para este usuario"),
            )
            : Expanded(
              child: Accordion(
                children: roles.map((rol) {
                  final documents = rolDocProvider.getDocumentsForRol(rol);
                  return AccordionSection(
                    header: Text(rol),
                    content: documents.isEmpty
                        ? const Center(
                      child: Text("No tiene documentos para este cargo"),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return buildDocumentCard(documents[index]);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            TextButton(
                onPressed: (){
                  final oadd = AadOAuth(MicrosoftID.config);
                  oadd.logout();
                },
                child: Text("Cerrar sesión")
            )
          ],
        ),
      )
    );
  }

}