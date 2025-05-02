import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/documents_sent_view.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class DocumentsSentScreen extends StatelessWidget {
  const DocumentsSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldFirmonec(
        title: "Documentos Enviados",
        initialSelectedIndex: 1,
        children: DocumentsSentView());
  }
}
