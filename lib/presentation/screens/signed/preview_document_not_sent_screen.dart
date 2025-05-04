import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class PreviewDocumentNotSentScreen extends StatelessWidget {
  const PreviewDocumentNotSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldFirmonec(
      title: "Previsuzalización no enviado",
      hideRefresh: true,
      children: PreviewDocumentNotSentView(),
    );
  }
}
