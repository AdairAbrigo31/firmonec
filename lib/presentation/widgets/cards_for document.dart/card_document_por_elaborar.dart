import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/infrastructure/auxiliars/auxiliars.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';
import 'package:tesis_firmonec/theme/theme.dart';

class CardDocumentPorElaborar extends ConsumerStatefulWidget {
  final RolEntity rol;
  final DocumentoPorElaborarEntity doc;

  const CardDocumentPorElaborar(
      {super.key, required this.doc, required this.rol});

  @override
  ConsumerState<CardDocumentPorElaborar> createState() {
    return _CardDocumentPorElaborarState();
  }
}

class _CardDocumentPorElaborarState
    extends ConsumerState<CardDocumentPorElaborar> {
  @override
  Widget build(BuildContext context) {
    final oneDocumentSelectedPreviewNotifier =
        ref.read(oneDocumentSelectedPreviewProvider.notifier);

    final fecha = DateTime.parse(widget.doc.fechaDocumento);

    final fechaFormateada = "${fecha.day}/${fecha.month}/${fecha.year}";

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
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      Text('Fecha: $fechaFormateada',
                          textAlign: TextAlign.start,
                          style: AppTypography.bodyMedium),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Categoria: ',
                              style: AppTypography.bodyMedium,
                            ),
                            TextSpan(
                              text: widget.doc.categoria,
                              style: TextStyle(
                                color: RolesWithDocumentsAuxiliars
                                    .getColorCategoryDocument(
                                        widget.doc.categoria),
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5))),
                  child: Text('Por Elaborar', style: AppTypography.bodyMedium),
                ),
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
                      oneDocumentSelectedPreviewNotifier
                          .setDocument(widget.doc);
                      oneDocumentSelectedPreviewNotifier.setRol(widget.rol);
                      router.pushNamed("preview_one_document");
                    },
                  )
                else
                  Text(
                    "No hay PDF",
                    style: AppTypography.bodySmall,
                  ),
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
