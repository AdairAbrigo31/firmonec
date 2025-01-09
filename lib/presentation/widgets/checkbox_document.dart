
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/entities/entities.dart';
import 'package:tesis_firmonec/infrastructure/entities/rol_entity.dart';
import 'package:tesis_firmonec/presentation/providers/signed/signed.dart';

class CheckboxDocument extends ConsumerWidget {
  final RolEntity rol;
  final DocumentEntity document;

  const CheckboxDocument({
    super.key,
    required this.rol,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsNotifier = ref.read(documentSelectedProvider.notifier);

    // Usar select para escuchar solo el cambio específico de este documento
    final isSelected = ref.watch(
        documentSelectedProvider.select(
                (state) => state.documentsSelected[rol]?.contains(document) ?? false
        )
    );

    return Checkbox(
      value: isSelected,
      onChanged: (_) {
        documentsNotifier.toggleDocumentSelection(rol, document);
      },
    );
  }
}