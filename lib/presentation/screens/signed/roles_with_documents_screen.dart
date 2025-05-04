import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/views/signed/roles_with_documents_view.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class RolesWithDocumentsScreen extends ConsumerWidget {
  const RolesWithDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldFirmonec(
        title: "Roles  documentos",
        hideRefresh: true,
        children: RolesWithDocumentsView());
  }
}
