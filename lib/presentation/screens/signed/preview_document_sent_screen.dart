import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class PreviewDocumentSentScreen extends StatelessWidget {
  const PreviewDocumentSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldFirmonec(
      title: "Previsuzalización enviado",
      hideRefresh: true,
      children: PreviewDocumentSentView(),
    );
  }
}
