import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/go_router.dart';
import 'package:tesis_firmonec/infrastructure/auxiliars/auxiliars.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/formats.dart';
import 'package:tesis_firmonec/presentation/providers/signed/document_sent_preview_provider.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class CardDocumentSent extends ConsumerStatefulWidget {
  final RolEntity rol;
  final DocumentSent doc;

  const CardDocumentSent({super.key, required this.doc, required this.rol});

  @override
  ConsumerState<CardDocumentSent> createState() {
    return _CardDocumentSentState();
  }
}

class _CardDocumentSentState extends ConsumerState<CardDocumentSent> {
  @override
  Widget build(BuildContext context) {
    final documentSentPreview = ref.read(documentSentPreviewProvider.notifier);

    final fechaFormateada = Formats.formatDate(widget.doc.fechaDocumento);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con badge de tipo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha: $fechaFormateada',
                    textAlign: TextAlign.start,
                    style: AppTypography.bodyMedium),
                RichText(
                  text: TextSpan(
                    text: widget.doc.categoria,
                    style: TextStyle(
                      color:
                          RolesWithDocumentsAuxiliars.getColorCategoryDocument(
                              widget.doc.categoria!),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),

            // Asunto con manejo de overflow
            Text(
              "Asunto: ${widget.doc.asunto}",
              style: AppTypography.bodyMediumBool,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 4),

            Text(
              'Para: ${widget.doc.para}',
              style: AppTypography.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.doc.rutaDocumento != null)
                  TextButton.icon(
                    label: Text(
                      'Ver PDF',
                      style: AppTypography.bodySmall,
                    ),
                    onPressed: () {
                      documentSentPreview.setDocument(widget.doc);
                      documentSentPreview.setRol(widget.rol);
                      router.pushNamed("preview_documents_sent");
                    },
                  )
                else
                  Text(
                    "No hay PDF",
                    style: AppTypography.bodySmall,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
