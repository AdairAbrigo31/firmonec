
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class CardDocumentReasignado extends ConsumerStatefulWidget {

  final RolEntity rol;
  final DocumentReasignadoEntity doc;

  const CardDocumentReasignado(this.rol, this.doc, {super.key});
  
  @override
  ConsumerState<CardDocumentReasignado> createState() {
    return _CardDocumentReasignadoState();
  }
}

class _CardDocumentReasignadoState extends ConsumerState<CardDocumentReasignado> {
  

  @override
  Widget build(BuildContext context) {

    final oneDocumentSelectedPreviewNotifier = ref.read(oneDocumentSelectedPreviewProvider.notifier);
    
    final fecha = DateTime.parse(widget.doc.fechaReasignacion);

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
              widget.doc.asunto,
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
                  'De: ${widget.doc.fechaReasignacion}',
                  style: const TextStyle(fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                Text(
                  'Para: ${widget.doc.reasignadoPor}',
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

                if (widget.doc.rutaDocumento != null)
                TextButton.icon(
                  icon: const Icon(Icons.visibility),
                  label: const Text('Ver PDF'),
                  onPressed: () {

                    oneDocumentSelectedPreviewNotifier.setDocument(widget.doc);
                    router.pushNamed('preview_one_document');
                    
                  },
                )

                else 
                const Text("No hay PDF"),

                const SizedBox(width: 8),
                
                CheckboxDocument(rol: widget.rol, document: widget.doc)
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}