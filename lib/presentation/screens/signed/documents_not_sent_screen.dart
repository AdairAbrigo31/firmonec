import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/views/signed/documents_not_sent_view.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class DocumentsNotSentScreen extends ConsumerWidget {
  const DocumentsNotSentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldFirmonec(
      title: "Documentos No Enviados",
      initialSelectedIndex: 2,
      children: DocumentsNotSentView(),
    );
  }
}
